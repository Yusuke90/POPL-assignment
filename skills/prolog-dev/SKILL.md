---
name: prolog-dev
description: Rules and checklist for writing, testing and reviewing SWI-Prolog 9.x code for CS F301 Assignment 2 (P1 department puzzle, P2 arithmetic equations). Use whenever the task involves a .pl file, a Prolog predicate, a clue/N clause, findall/aggregate, or running swipl. Apply the self-review checklist before every answer.
---

# prolog-dev

## 1. Language and environment
- SWI-Prolog 9.x. Files are `id_q1.pl` and `id_q2.pl` (replace `id` with the group ID).
- Allowed libraries ONLY: `lists`, `apply`, `yall`, `aggregate`. Add `:- use_module(library(...)).` directives for what is used, nothing else.
- Files contain ONLY definitions (and use_module directives). Loading a file must print nothing.

## 2. Hard bans (automatic fail if violated)
- No `halt/0` anywhere. The grader runs `-t halt` itself.
- No `initialization/1` or `initialization/2` directive of any kind.
- No `assert*`, `retract*`, `b_setval`, `nb_setval` or any global variable.
- No libraries beyond the four above (no clpfd, no dcg/basics, no strings, no readutil).
- No printing except what the task specifies. No debug `format`, `print`, `writeln`, `portray_clause` left behind. P2 prints nothing at all; P1 `main/0` prints exactly four lines.
- P2 only: never build a string and parse it back (`term_to_atom`, `term_string`, `atom_to_term`, `number_codes` round trips) to evaluate an expression.

## 3. Coding conventions
- Names: `snake_case` predicates and atoms; variables in `CamelCase`; `_` for singletons.
- One-line declarative reading in a comment directly above every predicate, e.g.
  `% clue(N, S): clue number N holds in the fully filled-in solution S.`
- Recursive predicates: say in a comment what the base case and the recursive case mean.
- Keep clauses short and simple. No clever tricks the author cannot explain in a viva.
- Group clauses of one predicate together (no discontiguous warnings).
- Deterministic helpers should leave no choice points: use first-argument indexing, `memberchk/2`, `once/1`, or `->` only where it is the clearest option.
- Quoted atoms exactly as specified: `'Alex'`, `'Ben'`, `'Carla'`, `'Dana'`, `'c++'`, `'AI'`. Unquoted: `research`, `development`, `design`, `testing`, `python`, `java`, `javascript`, `web`, `embedded`, `data`.
- P1 solution shape: list of four `p(Name, Dept, Lang, Project)` in the order Alex, Ben, Carla, Dana.
- P1 output: use `format("~w = [~w, ~w, ~w]~n", ...)` so `'c++'` and `'AI'` print without quotes.
- P2 equations are SWI-Prolog STRINGS (`string(E)` true), not atoms or code lists.

## 4. How to run and test
Load and run `main`:

    swipl -q -f code/id_q1.pl -g main -t halt

Run any other goal:

    swipl -q -f code/id_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8], N), format('~w~n', [N])" -t halt

Check that loading prints nothing and exits cleanly:

    swipl -q -f code/id_q1.pl -g true -t halt

Test file pattern (tests/ folder, a plain .pl file that loads the code, with no halt):

    :- consult('../code/id_q1.pl').
    test_count :- count_solutions([1,2,3,4,5,6,7,8], N), N =:= 3.

Run a test goal the same way as the grader: `-g test_count -t halt`. A failing goal prints a warning and exits non-zero, which is the signal.

## 5. Self-review checklist (apply before EVERY answer)
1. Does the code use only `lists`, `apply`, `yall`, `aggregate`?
2. Search the code for: `halt`, `initialization`, `assert`, `retract`, `setval`, `format`/`write`/`print` outside the allowed place. None may appear except the specified output.
3. Does loading the file print anything? It must not.
4. Each clue/predicate has a one-line declarative comment above it.
5. Quoted vs unquoted atoms match the task text exactly.
6. Does the predicate succeed exactly when specified, and fail (not error, not loop) otherwise? Test one passing and one failing input.
7. Any leftover choice points where the predicate should be deterministic? Check with `-g "(pred(...), true -> writeln(ok) ; writeln(no))"` or by asking for more solutions.
8. Any singleton-variable or discontiguous warnings on load? Fix them.
9. Is the code derived from the clues rather than hard-coding the answer (P1)?
10. Output format byte for byte: spacing, brackets, commas, trailing newline, no extra lines.
11. Does it use anything the task did not clearly allow? If unsure, stop and ask.
12. Can I explain every line in plain English? Add the explanation to the answer.

## 6. Known AI failure modes for Prolog
- Adding `:- initialization(main).` or calling `halt.` at the end of the file. Both are forbidden here.
- Using `assert`/`retract` or `nb_setval` to count or memoize.
- Importing `clpfd`, `dicts`, `readutil` or `strings` because they are convenient.
- Printing debug output or leaving a `print_message`/`writeln` in the file.
- Printing `'c++'` and `'AI'` with quotes (using `~q` or `print`) instead of `~w`.
- Producing atoms where strings are required (P2), or code lists from `format(codes(...))`.
- Writing `A \= B` where `dif/2` or `\==` was meant, and relying on unbound variables in negation. Check clues only on fully filled-in solutions.
- Putting the generator after the test (test with unbound variables), which silently passes or fails wrongly.
- Leaving choice points: `member/2` where `memberchk/2` is meant, or clause order that returns the same answer twice.
- `findall/3` over a goal with unbound free variables, giving duplicates or wrong counts. Check the count against the known cross-check values.
- Using `->` without an else branch, so the predicate silently fails.
- Confusing `=` (unify) with `=:=` (arithmetic equal) and `is`. Division with `/` returns non-integers: exact division needs `B =\= 0` and `A mod B =:= 0`, then `//`.
- Forgetting the end-of-clause period or mixing `,` and `;` so precedence changes the meaning.
- Claiming tests passed without running them. Only report output actually produced, otherwise give the command and expected output.
- Looping on empty or one-element lists. Always test `[]` and a single element.

## 7. Answer format for every unit prompt
1. The code (only the unit asked for).
2. A short plain-English explanation (the author must defend it in a viva).
3. A test with the exact command and expected output.
4. One line confirming the checklist in section 5 was applied.