implement main
    open core, stdio
class predicates
    pick : (integer* L, integer X [out], integer* Rest [out]) nondeterm.
    perm : (integer* L) -> integer* P nondeterm.

clauses
    pick([H | T], H, T).
    pick([H | T], X, [H | R]) :-
        pick(T, X, R).

    perm([]) = [].
    perm(L) = [X | perm(R)] :-
        pick(L, X, R).

clauses
    run() :-
        foreach P = perm([1, 2, 3]) do
            write(P, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
