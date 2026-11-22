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

% clue(N, S): clue number N holds in the fully filled-in solution S.

% Clue 1: the friend who prefers the AI project does not work in research
% and is not Dana. Find that friend by project, then check dept and name.
clue(1, S) :-
    memberchk(p(Name, Dept, _, 'AI'), S),
    Dept \== research,
    Name \== 'Dana'.

% Clue 2: Alex does not work in development and does not prefer C++.
% Find Alex by name, then check his dept and language.
clue(2, S) :-
    memberchk(p('Alex', Dept, Lang, _), S),
    Dept \== development,
    Lang \== 'c++'.    