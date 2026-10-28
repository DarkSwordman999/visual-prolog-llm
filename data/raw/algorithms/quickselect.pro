implement main
    open core, stdio
class predicates
    select : (integer K, integer* L) -> integer X determ.

clauses
    select(K, [P | T]) = X :-
        Less = [Y || Y in T, Y < P],
        More = [Y || Y in T, Y >= P],
        N = list::length(Less),
        if K <= N then
            X = select(K, Less)
        elseif K = N + 1 then
            X = P
        else
            X = select(K - N - 1, More)
        end if.

clauses
    run() :-
        L = [7, 10, 4, 3, 20, 15],
        foreach K in [1, 3, 6, 7] do
            if X = select(K, L) then
                write(K, "-й наименьший: ", X, "\n")
            else
                write(K, "-го элемента нет\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
