implement main
    open core, stdio
class predicates
    qsort : (integer* L) -> integer* S.
    partition : (integer P, integer* L, integer* Less [out], integer* More [out]).

clauses
    qsort([]) = [].
    qsort([P | T]) = list::append(qsort(Less), [P | qsort(More)]) :-
        partition(P, T, Less, More).

    partition(_, [], [], []).
    partition(P, [H | T], [H | L], M) :-
        H < P,
        !,
        partition(P, T, L, M).
    partition(P, [H | T], L, [H | M]) :-
        partition(P, T, L, M).

clauses
    run() :-
        write(qsort([3, 6, 8, 10, 1, 2, 1]), "\n").

end implement main

goal
    console::runUtf8(main::run).
