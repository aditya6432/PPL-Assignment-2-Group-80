:- use_module(library(lists), [append/3]).

% An expression tree preserves input order and carries its integer value.
expression_tree([N], leaf(N), N) :-
    integer(N), N >= 0.
expression_tree(Numbers, node(Op, LeftTree, RightTree), Value) :-
    append(Left, Right, Numbers),
    Left = [_ | _],
    Right = [_ | _],
    expression_tree(Left, LeftTree, LeftValue),
    expression_tree(Right, RightTree, RightValue),
    evaluate(Op, LeftValue, RightValue, Value).

evaluate('+', A, B, Value) :- Value is A + B.
evaluate('-', A, B, Value) :- Value is A - B.
evaluate('*', A, B, Value) :- Value is A * B.
evaluate('/', A, B, Value) :-
    B =\= 0,
    0 is A mod B,
    Value is A // B.

precedence('+', 1).
precedence('-', 1).
precedence('*', 2).
precedence('/', 2).

% Add parentheses exactly where the assignment's canonical rule requires.
operand_string(leaf(_), _, _, Bare, Bare).
operand_string(node(Op, _, _), ParentPrecedence, Side, Bare, Result) :-
    precedence(Op, ChildPrecedence),
    (   ChildPrecedence < ParentPrecedence
    ;   Side = right, ChildPrecedence =:= ParentPrecedence
    ) ->
        string_concat("(", Bare, Start),
        string_concat(Start, ")", Result)
    ;   Result = Bare.

tree_string(leaf(N), Text) :-
    number_string(N, Text).
tree_string(node(Op, Left, Right), Text) :-
    tree_string(Left, LeftBare),
    tree_string(Right, RightBare),
    precedence(Op, ParentPrecedence),
    operand_string(Left, ParentPrecedence, left, LeftBare, LeftText),
    operand_string(Right, ParentPrecedence, right, RightBare, RightText),
    atom_string(Op, OperatorText),
    string_concat(LeftText, OperatorText, Part),
    string_concat(Part, RightText, Text).

equation_string(Numbers, Equation) :-
    append(LeftNumbers, RightNumbers, Numbers),
    LeftNumbers = [_ | _],
    RightNumbers = [_ | _],
    expression_tree(LeftNumbers, LeftTree, LeftValue),
    expression_tree(RightNumbers, RightTree, RightValue),
    LeftValue =:= RightValue,
    tree_string(LeftTree, LeftText),
    tree_string(RightTree, RightText),
    string_concat(LeftText, "=", FirstPart),
    string_concat(FirstPart, RightText, Equation).

generate_equation(List, Equation) :-
    once(equation_string(List, Equation)).

all_equations(List, Equations) :-
    findall(Equation, equation_string(List, Equation), Unsorted),
    sort(Unsorted, Equations).

count_equations(List, N) :-
    all_equations(List, Equations),
    length(Equations, N).
