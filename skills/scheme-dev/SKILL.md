---
name: scheme-dev
description: Write, explain and test Racket 8.x (#lang racket/base) code for CS F301 Assignment 2 (S1 binary tree traversals, S2 conditional nested-list insert) using ONLY the assignment's allowed built-ins. Use for every Scheme unit in this repo.
---

# scheme-dev

Rules for writing Scheme for CS F301 Assignment 2. The assignment PDF is the
source of truth. If this file and the PDF ever disagree, the PDF wins.

## 1. Language and version

- Racket 8.x, run with `racket file.rkt`.
- Every code file starts with `#lang racket/base` and nothing else is required.
- No `(require ...)` of any kind. Nothing outside `racket/base` is available.

## 2. Allowed built-ins (and nothing else)

- Binding and control: `define`, `lambda`, `let`, `let*`, `letrec`, named `let`,
  `if`, `cond` (always with an `else` branch), `and`, `or`, `not`, `begin`,
  `quote` (written `'`).
- Pairs and lists: `cons`, `car`, `cdr`, `list`, and every car/cdr composition
  up to four levels (`cadr`, `cddr`, `caddr`, `cdddr`, `cadddr`, `cddddr`, ...).
- Predicates: `null?`, `pair?`, `eq?`.
- Association lists: `assq`, `assoc`.
- Arithmetic and comparison: `+ - * < > <= >= =`.
- Output: `display`, `newline`.
- Input: `read`, only in S2.

`max` is NOT on the PDF's list. Write a `my-max` helper with `if` instead:

    ;; (my-max a b) = a if a > b, else b
    (define (my-max a b) (if (> a b) a b))

Any other identifier in operator position must be a function defined in the
same file. If a unit seems to need something not listed here, STOP and ask the
student before using it.

## 3. Forbidden (common temptations)

`set!` and relatives, vectors, hash tables, strings, `length`, `append`,
`reverse`, `map`, `filter`, `member`, `memq`, `list-ref`, `list-tail`, `min`,
`abs`, `zero?`, `equal?`, `eqv?`, `list?`, `number?`, `symbol?`, `when`,
`unless`, `case`, `do`, `for` and all `for/...` forms, `apply`, `foldl`,
`foldr`, `let-values`, `printf`, `format`, `write`, `void`, `error`,
`first`, `rest`, `empty?`, `add1`, `sub1`, `quotient`, `remainder`, `modulo`,
`list*`, quasiquote. If you need the behaviour, write your own helper
(`my-reverse`, `my-length`, `my-map`, `my-append`, ...).

To tell atoms from lists use only `pair?` and `null?`:

- empty list: `(null? x)`
- non-empty list: `(pair? x)`
- atom: `(not (or (pair? x) (null? x)))`

## 4. File rules

- A code file contains ONLY `#lang racket/base` and `define`s.
- No top-level calls, no top-level `display`, nothing printed on load. The
  grader defines its own trees and appends its own calls after our code.
- Do not define `t1`, `t2`, `t3` or any test data in the code file. Test data
  and calls live in `tests/`.
- Each name is defined exactly once. In a module a duplicate `define` is an
  error. S2 ends with a single `insert-if-short` (the `make-inserter` one).
- Pass all state through function arguments (accumulators). No mutation.
- Prefer tail recursion where it is natural. Hidden tests use nesting depth 100
  and lists of 10,000 elements, so avoid anything quadratic.

## 5. Conventions

- Names: lowercase kebab-case (`print-inorder`, `my-length`). Predicates end
  in `?`. Own versions of forbidden built-ins are prefixed `my-`.
- Accumulator parameters are called `acc`. Loop helpers are named `loop` or
  `<name>-helper`.
- Above EVERY function put a one-line recursive reading, for example:

      ;; (my-length lst) = 0 if lst is empty, else 1 + (my-length (cdr lst))

  Tail-recursive helpers get a reading of the accumulator:

      ;; (len-acc lst acc) = acc if lst is empty, else (len-acc (cdr lst) (+ acc 1))

- Short `;;` comments only. No tricks the student cannot explain in a viva.
- 2-space indentation, one definition per blank-line-separated block.
- Output: `(display value)` then `(newline)`. Every printing function ends its
  output with a newline.

## 6. Workflow for each unit prompt

1. Apply the self-review checklist (section 8) before answering.
2. Give the code.
3. Give a short plain-English explanation the student can use in the viva
   (what each function does, why the recursion terminates, why it is correct).
4. Give a test and the exact command, with the expected output. If you cannot
   run Racket, say so and give the expected output; never claim a run you
   did not do.
5. Answer only the unit asked. Never write a whole problem in one go.

## 7. How to run and test

S1 (the test file holds the trees and the calls, with no `#lang` line):

    cat code/id_q3.rkt tests/s1_calls.rkt > /tmp/s1.rkt && racket /tmp/s1.rkt

S2 (the test file holds only the call `(print-insert-result)`):

    cat code/id_q4.rkt tests/s2_calls.rkt > /tmp/s2.rkt && echo "42 ((1 2) (3 4 5) (6) ()) 3" | racket /tmp/s2.rkt

Expected: `((42 1 2) (3 4 5) (42 6) (42))`

Test files must NOT contain `#lang`, because the code file already starts with
it. Racket prints the value of any top-level expression that is not void, so
test calls must be calls to printing functions only.

## 8. Self-review checklist (apply before every answer)

- [ ] Every operator and function name is on the allowed list (section 2) or
      is defined in the file. Scan each line, including helpers.
- [ ] No forbidden name from section 3 appears, even as an argument.
- [ ] `max` is not used; `my-max` is.
- [ ] Every `cond` has an `else`.
- [ ] File starts with `#lang racket/base` and contains only definitions.
- [ ] No top-level calls, nothing printed on load, no test data in the code file.
- [ ] Each name is defined once (no duplicate `insert-if-short`).
- [ ] No mutation, no `set!`; state travels through arguments.
- [ ] Empty-list base case present and correct; recursion shrinks toward it.
- [ ] Tail recursion used where natural; nothing quadratic for 10,000 elements.
- [ ] Atom vs list checks use only `pair?` and `null?`.
- [ ] Each function has its one-line recursive reading above it.
- [ ] Output ends with a newline and prints nothing extra.
- [ ] Edge cases traced by hand: empty input, single element, depth 100.
- [ ] Explanation and test with command and expected output included.

## 9. Known AI failure modes for Scheme

- Reaching for `length`, `append`, `reverse`, `map`, `filter`, `member`,
  `list-ref`, `list-tail`, `min` or `max` out of habit.
- Using `equal?`, `list?`, `number?`, `symbol?`, `zero?`, `abs` because they
  feel basic. None is allowed here.
- Using `when`, `unless`, `case`, `do`, `for`, `apply`, `foldl`, `let-values`.
- Using `set!` or any mutation to build results or count things.
- Using `first`/`rest`/`empty?` (Racket habits, and not in `racket/base`).
- Using `printf`, `format`, `write` or `error` instead of `display`.
- Adding top-level calls such as `(print-inorder t1)` or `(define t1 ...)` to
  the code file, so output appears on load or the grader's trees clash.
- Defining the same function twice (for example both the S2.b and S2.c
  versions of `insert-if-short`), which is a module error.
- A `cond` with no `else`, which returns void and prints odd output.
- Measuring a list's length AFTER inserting the new element in S2 instead of on
  the original list.
- Forgetting that `()` is not an atom and must still be processed as a list
  (so `()` can become `(x)`).
- Treating the top-level list differently from nested ones in S2.
- Building results by naive append in a loop, which is quadratic on 10,000
  elements.
- Printing an extra prompt or label, or forgetting the final `(newline)`.
- Including a `#lang` line in a test file that gets concatenated.
- Claiming the code was run when it was not.

## 10. Quick lint (run from the repo root; no output means clean)

Forbidden names (comments may cause false positives; ignore those):

    grep -nE '[( ](length|append|reverse|map|filter|member|memq|list-ref|list-tail|min|max|abs|zero\?|equal\?|eqv\?|list\?|number\?|symbol\?|when|unless|case|apply|foldl|foldr|printf|format|write|void|error|set!|first|rest|empty\?|add1|sub1)[ )]' code/id_q3.rkt code/id_q4.rkt

Top-level forms that are not definitions (the `#lang` line is fine):

    grep -nE '^\(' code/id_q3.rkt code/id_q4.rkt | grep -v ':(define'

Duplicate `insert-if-short` (expect exactly `1`):

    grep -c '(define (insert-if-short' code/id_q4.rkt