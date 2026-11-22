:- use_module(library(lists)).

% split_nonempty(List, Left, Right): Left and Right are nonempty consecutive parts of List.
split_nonempty(List, Left, Right) :-
    append(Left, Right, List),
    Left = [_|_],
    Right = [_|_].

% apply_op(Op, A, B, V): V is the result of applying Op to integer operands A and B.
apply_op('+', A, B, V) :-
    V is A + B.
apply_op('-', A, B, V) :-
    V is A - B.
apply_op('*', A, B, V) :-
    V is A * B.
apply_op('/', A, B, V) :-
    B =\= 0,
    A mod B =:= 0,
    V is A // B. 

