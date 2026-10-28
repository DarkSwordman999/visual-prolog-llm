implement main
    open core, stdio
class predicates
    rotate : (integer* L, integer K) -> integer* R.
    append : (integer* A, integer* B) -> integer* C.

clauses
    rotate(L, 0) = L :-
        !.
    rotate([], _) = [] :-
        !.
    rotate([H | T], K) = rotate(append(T, [H]), K - 1).

    append([], B) = B.
    append([H | T], B) = [H | append(T, B)].

clauses
    run() :-
        L = [1, 2, 3, 4, 5],
        foreach K in [0, 1, 2, 7] do
            write("Сдвиг на ", K, ": ", rotate(L, K mod list::length(L)), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
