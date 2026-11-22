#!/bin/bash
# S2 tests for print-insert-result (reads x, lst, n from stdin).
# Run from the repo root:  bash tests/s2_tests.sh
# Needs: code/74_q4.rkt and tests/s2_calls.rkt (the single line "(print-insert-result)")
# Prints nothing but the final summary line when every test passes.

cat code/74_q4.rkt tests/s2_calls.rkt > /tmp/s2.rkt
pass=0
fail=0

# rep STRING COUNT = STRING repeated COUNT times
rep() {
  local out="" i
  for ((i = 0; i < $2; i++)); do out="$out$1"; done
  printf '%s' "$out"
}

# check NAME INPUT EXPECTED = feed INPUT on stdin, compare the output with EXPECTED
check() {
  local actual
  actual=$(printf '%s\n' "$2" | racket /tmp/s2.rkt)
  if [ "$actual" = "$3" ]; then
    pass=$((pass + 1))
  else
    fail=$((fail + 1))
    echo "FAIL: $1"
    echo "  expected: ${3:0:100}"
    echo "  actual:   ${actual:0:100}"
  fi
}

# ---- examples from the PDF ----
check "pdf 1" "42 ((1 2) (3 4 5) (6) ()) 3" "((42 1 2) (3 4 5) (42 6) (42))"
check "pdf 2" "0 (((1) 2) (3) ((4 5 6) ())) 3" "((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))"
check "pdf 3, empty top-level, n=3" "7 () 3" "(7)"
check "pdf 4, empty top-level, n=0" "7 () 0" "()"

# ---- our own edge cases ----
# symbol x, and the three inputs on separate lines
check "inputs on separate lines" "z"$'\n'"(a (b))"$'\n'"2" "(a (z b))"
check "n=0 inserts nothing" "9 (1 () (2)) 0" "(1 () (2))"
check "length equal to n: no insert" "z (a b c) 3" "(a b c)"
check "length less than n: insert" "z (a b c) 4" "(z a b c)"
check "nested empty lists" "e (() (())) 2" "((e) (e (e)))"
check "mixed lengths, order kept" "0 ((1) 2 (3 4 5 6)) 4" "(0 (0 1) 2 (3 4 5 6))"
check "length measured on the original" "z ((a) (b)) 2" "((z a) (z b))"

# ---- depth 100: 100 nested lists, the innermost is () ----
open=$(rep '(' 100)
close=$(rep ')' 100)
check "depth 100, n=2 (every list gets z)" "z $open$close 2" "$(rep '(z ' 99)(z)$(rep ')' 99)"
check "depth 100, n=1 (only the empty list gets z)" "z $open$close 1" "$(rep '(' 99)(z)$(rep ')' 99)"

# ---- 10,000 elements ----
nums=$(seq -s ' ' 1 10000)
check "10000 atoms, n=10001 (insert)" "z ($nums) 10001" "(z $nums)"
check "10000 atoms, n=10000 (no insert)" "z ($nums) 10000" "($nums)"
subs=$(echo "$nums" | sed 's/[0-9][0-9]*/(a)/g')
subs_z=$(echo "$nums" | sed 's/[0-9][0-9]*/(z a)/g')
check "10000 sublists, n=2" "z ($subs) 2" "($subs_z)"

# ---- exactly one line of output, no prompt or extra text ----
lines=$(printf '%s\n' "42 ((1 2) (3 4 5) (6) ()) 3" | racket /tmp/s2.rkt | wc -l | tr -d ' ')
if [ "$lines" = "1" ]; then
  pass=$((pass + 1))
else
  fail=$((fail + 1))
  echo "FAIL: output should be exactly one line, got $lines"
fi

echo "PASS: $pass FAIL: $fail"
[ "$fail" = 0 ]