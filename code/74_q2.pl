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

% expr(Nums, Tree, Value): Tree uses every number in Nums in order and evaluates to Value.
% Base case: a one-number list gives a num/1 tree.
% Recursive case: split the list, build each side, then apply an operator at the root.
expr([N], num(N), N).
expr(Nums, bin(Op, Left, Right), Value) :-
    split_nonempty(Nums, LeftNums, RightNums),
    expr(LeftNums, Left, LeftValue),
    expr(RightNums, Right, RightValue),
    apply_op(Op, LeftValue, RightValue, Value).  

