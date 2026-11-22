% P1: Department Assignment Puzzle, Reloaded
% Only definitions here: no halt, no initialization, no printing on load.

:- use_module(library(lists)).
:- use_module(library(apply)).
:- use_module(library(yall)).
:- use_module(library(aggregate)).

% solution(S): S is a candidate list p(Name, Dept, Lang, Project) in the order
% Alex, Ben, Carla, Dana, where each attribute uses its four values exactly once.
solution(S) :-
    permutation([research, development, design, testing], Depts),
    permutation([python, java, 'c++', javascript], Langs),
    permutation(['AI', web, embedded, data], Projects),
    make_people(['Alex', 'Ben', 'Carla', 'Dana'], Depts, Langs, Projects, S).

% make_people(Names, Depts, Langs, Projects, People): People pairs up the i-th
% element of each of the four lists into p(Name, Dept, Lang, Project).
% Base case: empty lists give an empty list. Recursive case: build the head
% term, then recurse on the tails.
make_people([], [], [], [], []).
make_people([N|Ns], [D|Ds], [L|Ls], [P|Ps], [p(N, D, L, P)|Rest]) :-
    make_people(Ns, Ds, Ls, Ps, Rest).  
