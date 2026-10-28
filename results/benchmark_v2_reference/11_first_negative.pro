implement main
    open core, stdio
class predicates
    firstNeg : (integer* L, integer Pos) -> integer P determ.

clauses
    firstNeg([H | _], Pos) = Pos :-
        H < 0,
        !.
    firstNeg([_ | T], Pos) = firstNeg(T, Pos + 1).

clauses
    run() :-
        if P = firstNeg([5, 3, -2, 7, -1], 1) then
            write(P, "\n")
        end if.

end implement main

goal
    console::runUtf8(main::run).
