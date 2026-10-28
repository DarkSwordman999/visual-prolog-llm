implement main
    open core, stdio
class predicates
    transpose : (integer** M) -> integer** T.
    heads : (integer** M) -> integer* H.
    tails : (integer** M) -> integer** T.
    dot : (integer* A, integer* B) -> integer S.
    multiply : (integer** A, integer** B) -> integer** C.

clauses
    transpose([[] | _]) = [] :-
        !.
    transpose([]) = [] :-
        !.
    transpose(M) = [heads(M) | transpose(tails(M))].

    heads([]) = [].
    heads([[H | _] | Rows]) = [H | heads(Rows)] :-
        !.
    heads([_ | Rows]) = heads(Rows).

    tails([]) = [].
    tails([[_ | T] | Rows]) = [T | tails(Rows)] :-
        !.
    tails([_ | Rows]) = tails(Rows).

    dot([X | Xs], [Y | Ys]) = X * Y + dot(Xs, Ys) :-
        !.
    dot(_, _) = 0.

    multiply(A, B) = [[dot(Row, Col) || Col in BT] || Row in A] :-
        BT = transpose(B).

clauses
    run() :-
        A = [[1, 2, 3], [4, 5, 6]],
        B = [[7, 8], [9, 10], [11, 12]],
        write("A = ", A, "\n"),
        write("A^T = ", transpose(A), "\n"),
        write("A * B = ", multiply(A, B), "\n").

end implement main

goal
    console::runUtf8(main::run).
