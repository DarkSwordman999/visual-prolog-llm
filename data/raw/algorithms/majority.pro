implement main
    open core, stdio
class predicates
    vote : (integer* L, integer Cand, integer Count) -> integer C.
    count : (integer X, integer* L) -> integer N.

clauses
    vote([], Cand, _) = Cand.
    vote([H | T], _, 0) = vote(T, H, 1) :-
        !.
    vote([H | T], Cand, N) = vote(T, Cand, N + 1) :-
        H = Cand,
        !.
    vote([_ | T], Cand, N) = vote(T, Cand, N - 1).

    count(X, L) = list::length([Y || Y in L, Y = X]).

clauses
    run() :-
        foreach L in [[2, 2, 1, 1, 2, 2, 3], [1, 2, 3, 1], [5]] do
            C = vote(L, 0, 0),
            if 2 * count(C, L) > list::length(L) then
                write(L, ": большинство ", C, "\n")
            else
                write(L, ": элемента большинства нет\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
