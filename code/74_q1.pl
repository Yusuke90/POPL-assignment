% P1: Department Assignment Puzzle, Reloaded
% Only definitions here: nothing runs or prints on load.

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

% Clue 3: the friend working in the testing department likes Python.
% Find that friend by department, then check the language.
clue(3, S) :-
    memberchk(p(_, testing, Lang, _), S),
    Lang == python.

% Clue 4: Ben prefers web projects and does not work in testing.
% Find Ben by name, then check his project and department.
clue(4, S) :-
    memberchk(p('Ben', Dept, _, Project), S),
    Project == web,
    Dept \== testing. 

% Clue 5: the friend whose favorite language is Java works in the design department.
% Find that friend by language, then check the department.
clue(5, S) :-
    memberchk(p(_, Dept, java, _), S),
    Dept == design. 

% Clue 6: Carla's project preference is not embedded, and her department
% is not development. Find Carla by name, then check project and department.
clue(6, S) :-
    memberchk(p('Carla', Dept, _, Project), S),
    Project \== embedded,
    Dept \== development.

% Clue 7: Dana's favorite language is not Java, and she works in research
% or testing. Find Dana by name, then check language and department.
clue(7, S) :-
    memberchk(p('Dana', Dept, Lang, _), S),
    Lang \== java,
    memberchk(Dept, [research, testing]). 

% Clue 8: the friend who prefers data projects works in research and does not
% use JavaScript. Find that friend by project, then check dept and language.
clue(8, S) :-
    memberchk(p(_, Dept, Lang, data), S),
    Dept == research,
    Lang \== javascript.


% main: print the first solution that satisfies clues 1 to 8, one line per friend.
% once/1 stops the search at the first solution; forall/2 checks every clue.
main :-
    once(( solution(S),
           forall(between(1, 8, N), clue(N, S)) )),
    print_people(S).

% print_people(People): print one line "Name = [Dept, Lang, Project]" per friend.
% Base case: no friends left. Recursive case: print the head, then the rest.
% ~w prints atoms without quotes, so 'c++' and 'AI' appear as c++ and AI.
print_people([]).
print_people([p(Name, Dept, Lang, Project)|Rest]) :-
    format("~w = [~w, ~w, ~w]~n", [Name, Dept, Lang, Project]),
    print_people(Rest).


% count_solutions(Active, N): N is the number of candidate solutions in which
% every clue listed in Active holds; clues not in Active are ignored.
% findall/3 collects each candidate that passes all active clues, and
% length/2 counts them.
count_solutions(Active, N) :-
    findall(S,
            ( solution(S),
              forall(member(C, Active), clue(C, S)) ),
            Solutions),
    length(Solutions, N).                             