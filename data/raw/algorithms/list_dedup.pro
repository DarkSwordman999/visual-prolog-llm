implement main
    open core, stdio
class predicates
    dedup : (integer* L, integer* Seen) -> integer* R.
    member : (integer X, integer* L) determ.

clauses
    dedup([], _) = [].
    dedup([H | T], Seen) = dedup(T, Seen) :-
        member(H, Seen),
        !.
    dedup([H | T], Seen) = [H | dedup(T, [H | Seen])].

    member(X, [X | _]) :-
        !.
    member(X, [_ | T]) :-
        member(X, T).

clauses
    run() :-
        write(dedup([3, 1, 3, 2, 1, 5, 2], []), "\n").

end implement main

goal
    console::runUtf8(main::run).
