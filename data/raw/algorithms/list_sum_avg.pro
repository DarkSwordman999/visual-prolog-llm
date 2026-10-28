implement main
    open core, stdio
class predicates
    sum : (integer* L) -> integer S.
    len : (integer* L) -> integer N.

clauses
    sum([]) = 0.
    sum([H | T]) = H + sum(T).

    len([]) = 0.
    len([_ | T]) = 1 + len(T).

clauses
    run() :-
        L = [4, 8, 15, 16, 23, 42],
        S = sum(L),
        N = len(L),
        write("Список: ", L, "\n"),
        write("Сумма: ", S, ", длина: ", N, "\n"),
        write("Среднее: ", convert(real, S) / N, "\n").

end implement main

goal
    console::runUtf8(main::run).
