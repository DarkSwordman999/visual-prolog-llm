implement main
    open core, stdio
class predicates
    queens : (integer N, integer Row, integer* Placed) -> integer* Solution nondeterm.
    safe : (integer Col, integer* Placed, integer Dist) determ.
    abs : (integer X) -> integer A.

clauses
    queens(N, Row, Placed) = list::reverse(Placed) :-
        Row > N,
        !.
    queens(N, Row, Placed) = queens(N, Row + 1, [Col | Placed]) :-
        Col = std::fromTo(1, N),
        safe(Col, Placed, 1).

    safe(_, [], _).
    safe(C, [Q | T], D) :-
        C <> Q,
        abs(C - Q) <> D,
        safe(C, T, D + 1).

    abs(X) = -X :-
        X < 0,
        !.
    abs(X) = X.

clauses
    run() :-
        foreach N in [4, 6, 8] do
            All = [S || S = queens(N, 1, [])],
            write(N, " ферзей: решений ", list::length(All)),
            if [First | _] = All then
                write(", первое ", First)
            end if,
            write("\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
