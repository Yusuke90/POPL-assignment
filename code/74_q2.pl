:- use_module(library(lists)).

% split_nonempty(List, Left, Right): Left and Right are nonempty consecutive parts of List.
split_nonempty(List, Left, Right) :-
    append(Left, Right, List),
    Left = [_|_],
    Right = [_|_].

