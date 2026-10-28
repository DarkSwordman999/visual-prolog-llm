implement main
    open core, stdio
class predicates
    sqrt : (real A) -> real X.
    iterate : (real A, real X) -> real R.

clauses
    sqrt(0) = 0 :-
        !.
    sqrt(A) = iterate(A, A).

    iterate(A, X) = X :-
        math::abs(X * X - A) < 1e-12,
        !.
    iterate(A, X) = iterate(A, (X + A / X) / 2).

clauses
    run() :-
        foreach A in [2.0, 9.0, 0.25, 1000000.0] do
            write("sqrt(", A, ") = ", math::round(sqrt(A) * 1000000) / 1000000.0, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
