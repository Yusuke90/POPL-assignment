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

% prec(Op, Precedence): arithmetic operators have their specified precedence.
prec('+', 1).
prec('-', 1).
prec('*', 2).
prec('/', 2).

% tree_string(Tree, String): String renders Tree with the required parentheses.
% Base case: a number becomes its decimal string.
% Recursive case: render both subtrees and parenthesize them according to precedence.
tree_string(num(N), String) :-
    number_string(N, String).
tree_string(bin(Op, Left, Right), String) :-
    prec(Op, ParentPrec),
    tree_string(Left, LeftRaw),
    tree_string(Right, RightRaw),
    ( Left = bin(LeftOp, _, _),
      prec(LeftOp, LeftPrec),
      LeftPrec < ParentPrec
    -> string_concat("(", LeftRaw, LeftStart),
       string_concat(LeftStart, ")", LeftString)
    ;  LeftString = LeftRaw
    ),
    ( Right = bin(RightOp, _, _),
      prec(RightOp, RightPrec),
      RightPrec =< ParentPrec
    -> string_concat("(", RightRaw, RightStart),
       string_concat(RightStart, ")", RightString)
    ;  RightString = RightRaw
    ),
    atom_string(Op, OpString),
    string_concat(LeftString, OpString, FirstPart),
    string_concat(FirstPart, RightString, String).

