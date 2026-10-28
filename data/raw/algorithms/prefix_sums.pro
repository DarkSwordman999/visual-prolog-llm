implement main
    open core, stdio
class predicates
    prefix : (integer* L, integer S) -> integer* P.
    rangeSum : (integer* P, positive L, positive R) -> integer S.

clauses
    prefix([], _) = [].
    prefix([H | T], S) = [S + H | prefix(T, S + H)].

    rangeSum(P, 0, R) = list::nth(R, P) :-
        !.
    rangeSum(P, L, R) = list::nth(R, P) - list::nth(L - 1, P).

clauses
    run() :-
        L = [3, 1, 4, 1, 5, 9, 2, 6],
        P = prefix(L, 0),
        write("Префиксные суммы: ", P, "\n"),
        write("Сумма элементов 2..5: ", rangeSum(P, 2, 5), "\n"),
        write("Сумма элементов 0..3: ", rangeSum(P, 0, 3), "\n").

end implement main

goal
    console::runUtf8(main::run).
