% tests/p1_tests.pl: tests for P1 (code/74_q1.pl).
% Run from the repo root. Replace id in the consult line below with your group ID:
%   swipl -q -f tests/p1_tests.pl -g run_tests -t halt
% Prints one PASS/FAIL line per test and a summary. The run fails (non-zero
% exit) if any test fails.

:- consult('../code/74_q1.pl').

% test/2, holds/2 and fails/2 clauses are spread over the file on purpose.
:- discontiguous test/2, holds/2, fails/2.

% ---------- test runner ----------

% run_tests: run every test/2 fact, print the result, fail if any failed.
run_tests :-
    findall(Name, ( test(Name, Goal), \+ report(Name, Goal) ), Failed),
    length(Failed, NumFailed),
    ( NumFailed =:= 0
    -> format("All tests passed~n")
    ;  format("~w test(s) FAILED~n", [NumFailed]),
       fail
    ).

% report(Name, Goal): run Goal once (errors count as failure), print PASS or FAIL.
report(Name, Goal) :-
    (   catch(Goal, _, fail)
    ->  format("PASS ~w~n", [Name])
    ;   format("FAIL ~w~n", [Name]),
        fail
    ).

% ---------- main/0 output format ----------

expected_main_output("Alex = [design, java, AI]\nBen = [development, javascript, web]\nCarla = [research, c++, data]\nDana = [testing, python, embedded]\n").

% main prints exactly the expected four lines (first of the three solutions).
test(main_output_exact,
     ( with_output_to(string(Out), main),
       expected_main_output(Expected),
       Out == Expected )).

% main prints exactly four lines and nothing else (split gives 4 lines + "").
test(main_four_lines,
     ( with_output_to(string(Out), main),
       split_string(Out, "\n", "", Parts),
       length(Parts, 5),
       last(Parts, "") )).

% Loading code/74_q1.pl printed nothing is checked by hand:
%   swipl -q -f code/74_q1.pl -g true -t halt   (expect no output)

% ---------- solution/1 ----------

% There are 4! * 4! * 4! = 13824 candidates.
test(candidate_count,
     ( aggregate_all(count, solution(_), N), N =:= 13824 )).

% The first candidate has the right shape and quoting.
test(first_candidate,
     ( solution(S), !,
       S == [ p('Alex', research, python, 'AI'),
              p('Ben', development, java, web),
              p('Carla', design, 'c++', embedded),
              p('Dana', testing, javascript, data) ] )).

% ---------- count_solutions/2 ----------

% expect_count(Active, N): count_solutions(Active, N) must give this N.
expect_count([], 13824).
expect_count([1], 7776).
expect_count([2], 7776).
expect_count([3], 3456).
expect_count([4], 2592).
expect_count([5], 3456).
expect_count([6], 7776).
expect_count([7], 5184).
expect_count([8], 2592).
expect_count([1,2,3,4,5,6,7,8], 3).
expect_count([8,7,6,5,4,3,2,1], 3).   % order of Active does not matter

test(count(Active),
     ( count_solutions(Active, N), N =:= Expected )) :-
    expect_count(Active, Expected).

% drop_count(Clue, N): clues 1..8 without Clue give N solutions.
drop_count(1, 4).
drop_count(2, 6).
drop_count(3, 13).
drop_count(4, 12).
drop_count(5, 9).
drop_count(6, 7).
drop_count(7, 5).
drop_count(8, 16).

test(drop_one(D),
     ( findall(C, ( between(1, 8, C), C \== D ), Active),
       count_solutions(Active, N),
       N =:= Expected )) :-
    drop_count(D, Expected).

% count_solutions leaves no choice points.
test(count_deterministic,
     ( call_cleanup(count_solutions([1,2], _), Det = true), Det == true )).

% ---------- clue/2: one passing and failing cases per clue ----------
% holds(N, S): clue N must succeed on S.  fails(N, S): clue N must fail on S.

holds(1, [p('Alex',research,python,web),p('Ben',design,java,'AI'),p('Carla',testing,'c++',embedded),p('Dana',development,javascript,data)]).
fails(1, [p('Alex',research,python,'AI'),p('Ben',design,java,web),p('Carla',testing,'c++',embedded),p('Dana',development,javascript,data)]).
fails(1, [p('Alex',research,python,web),p('Ben',design,java,embedded),p('Carla',testing,'c++',data),p('Dana',development,javascript,'AI')]).
holds(2, [p('Alex',research,python,'AI'),p('Ben',development,java,web),p('Carla',design,'c++',embedded),p('Dana',testing,javascript,data)]).
fails(2, [p('Alex',development,python,'AI'),p('Ben',research,java,web),p('Carla',design,'c++',embedded),p('Dana',testing,javascript,data)]).
fails(2, [p('Alex',research,'c++','AI'),p('Ben',development,java,web),p('Carla',design,python,embedded),p('Dana',testing,javascript,data)]).
holds(3, [p('Alex',research,java,'AI'),p('Ben',development,'c++',web),p('Carla',design,javascript,embedded),p('Dana',testing,python,data)]).
fails(3, [p('Alex',research,python,'AI'),p('Ben',development,'c++',web),p('Carla',design,javascript,embedded),p('Dana',testing,java,data)]).
holds(4, [p('Alex',research,python,'AI'),p('Ben',development,java,web),p('Carla',design,'c++',embedded),p('Dana',testing,javascript,data)]).
fails(4, [p('Alex',research,python,web),p('Ben',development,java,data),p('Carla',design,'c++',embedded),p('Dana',testing,javascript,'AI')]).
fails(4, [p('Alex',research,python,'AI'),p('Ben',testing,java,web),p('Carla',design,'c++',embedded),p('Dana',development,javascript,data)]).
holds(5, [p('Alex',research,python,'AI'),p('Ben',design,java,web),p('Carla',development,'c++',embedded),p('Dana',testing,javascript,data)]).
fails(5, [p('Alex',research,python,'AI'),p('Ben',development,java,web),p('Carla',design,'c++',embedded),p('Dana',testing,javascript,data)]).
holds(6, [p('Alex',research,python,'AI'),p('Ben',development,java,web),p('Carla',design,'c++',data),p('Dana',testing,javascript,embedded)]).
fails(6, [p('Alex',research,python,'AI'),p('Ben',development,java,web),p('Carla',design,'c++',embedded),p('Dana',testing,javascript,data)]).
fails(6, [p('Alex',research,python,'AI'),p('Ben',design,java,web),p('Carla',development,'c++',data),p('Dana',testing,javascript,embedded)]).
holds(7, [p('Alex',research,python,'AI'),p('Ben',development,java,web),p('Carla',design,'c++',embedded),p('Dana',testing,javascript,data)]).
holds(7, [p('Alex',testing,python,'AI'),p('Ben',development,java,web),p('Carla',design,'c++',embedded),p('Dana',research,javascript,data)]).
fails(7, [p('Alex',development,python,'AI'),p('Ben',design,'c++',web),p('Carla',testing,javascript,embedded),p('Dana',research,java,data)]).
fails(7, [p('Alex',research,python,'AI'),p('Ben',development,java,web),p('Carla',testing,'c++',embedded),p('Dana',design,javascript,data)]).
holds(8, [p('Alex',research,python,data),p('Ben',development,java,web),p('Carla',design,'c++',embedded),p('Dana',testing,javascript,'AI')]).
fails(8, [p('Alex',research,python,'AI'),p('Ben',development,java,web),p('Carla',design,'c++',data),p('Dana',testing,javascript,embedded)]).
fails(8, [p('Alex',research,javascript,data),p('Ben',development,java,web),p('Carla',design,'c++',embedded),p('Dana',testing,python,'AI')]).

test(holds(N), clue(N, S)) :-
    holds(N, S).

test(fails(N), \+ clue(N, S)) :-
    fails(N, S).

% Each passing clue case leaves no choice points.
test(clue_deterministic(N),
     ( call_cleanup(clue(N, S), Det = true), Det == true )) :-
    holds(N, S).
