implement main
    open core, stdio
class predicates
    isSorted : (integer* L) determ.

clauses
    isSorted([]) :-
        !.
    isSorted([_]) :-
        !.
    isSorted([A, B | T]) :-
        A <= B,
        isSorted([B | T]).

clauses
    run() :-
        foreach L in [[1, 2, 2, 5], [3, 1, 2], [], [7]] do
            write(L, if isSorted(L) then " - упорядочен" else " - не упорядочен" end if, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
