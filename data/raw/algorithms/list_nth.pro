implement main
    open core, stdio
class predicates
    nth : (integer I, integer* L) -> integer X determ.

clauses
    nth(0, [H | _]) = H :-
        !.
    nth(I, [_ | T]) = nth(I - 1, T) :-
        I > 0.

clauses
    run() :-
        L = [10, 20, 30, 40],
        foreach I in [0, 2, 3, 7] do
            if X = nth(I, L) then
                write("Элемент ", I, ": ", X, "\n")
            else
                write("Элемента ", I, " нет\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
