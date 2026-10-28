implement main
    open core, stdio
domains
    expr = num(integer); add(expr, expr); sub(expr, expr); mul(expr, expr).

class predicates
    eval : (expr E) -> integer V.
    show : (expr E) -> string S.

clauses
    eval(num(X)) = X.
    eval(add(A, B)) = eval(A) + eval(B).
    eval(sub(A, B)) = eval(A) - eval(B).
    eval(mul(A, B)) = eval(A) * eval(B).

    show(num(X)) = toString(X).
    show(add(A, B)) = string::concat("(", show(A), " + ", show(B), ")").
    show(sub(A, B)) = string::concat("(", show(A), " - ", show(B), ")").
    show(mul(A, B)) = string::concat(show(A), " * ", show(B)).

clauses
    run() :-
        E = mul(add(num(2), num(3)), sub(num(10), num(4))),
        write(show(E), " = ", eval(E), "\n").

end implement main

goal
    console::runUtf8(main::run).
