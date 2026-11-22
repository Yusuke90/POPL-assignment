:- use_module(library(apply)).
:- consult('../code/74_q2.pl').

% check_equations(List, ExpectedCodes): all equations match the expected strings and are strings.
check_equations(List, ExpectedCodes) :-
    all_equations(List, Equations),
    maplist(string, Equations),
    maplist(string_codes, Expected, ExpectedCodes),
    sort(Expected, SortedExpected),
    Equations == SortedExpected.

% test_all_equations: cross-check example lists against their expected equations.
test_all_equations :-
    check_equations([4,2,5,3],
        [[52,42,50,45,53,61,51],
         [52,42,50,61,53,43,51],
         [52,45,50,61,53,45,51],
         [52,47,50,61,53,45,51],
         [52,61,50,42,40,53,45,51,41],
         [52,61,50,43,40,53,45,51,41],
         [52,61,50,43,53,45,51]]),
    check_equations([2,4,8],
        [[50,42,52,61,56]]),
    check_equations([2,3,4], []),
    check_equations([1,1],
        [[49,61,49]]),
    check_equations([0,0],
        [[48,61,48]]),
    check_equations([1,2,3],
        [[49,43,50,61,51]]),
    check_equations([3,5,2],
        [[51,61,53,45,50]]),
    check_equations([6,3,2],
        [[54,47,51,61,50],
         [54,61,51,42,50]]),
    check_equations([1,2,3,4],
        [[49,45,50,61,51,45,52],
         [49,61,50,43,40,51,45,52,41],
         [49,61,50,43,51,45,52]]),
    check_equations([9,3,3,1],
        [[57,47,40,51,42,51,41,61,49],
         [57,47,51,47,51,61,49],
         [57,47,51,61,51,42,49],
         [57,47,51,61,51,47,49],
         [57,61,51,42,40,51,42,49,41],
         [57,61,51,42,40,51,47,49,41],
         [57,61,51,42,51,42,49],
         [57,61,51,42,51,47,49]]),
    check_equations([], []),
    check_equations([5], []).

% test_counts: the documented lists have the expected number of equations.
test_counts :-
    count_equations([1,2,3,4,5], 14),
    count_equations([2,2,2,2], 26),
    count_equations([2,2,2,2,2,2], 1620).

% test_generate_failures: generate_equation/2 fails when no equation exists.
test_generate_failures :-
    \+ generate_equation([2,3,4], _),
    \+ generate_equation([], _),
    \+ generate_equation([5], _).