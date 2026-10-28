implement main
    open core, stdio
class predicates
    ways : (integer S, integer* Coins) -> integer N.

clauses
    ways(S, _) = 0 :-
        S < 0,
        !.
    ways(0, _) = 1 :-
        !.
    ways(_, []) = 0.
    ways(S, [C | Cs]) = ways(S - C, [C | Cs]) + ways(S, Cs).

clauses
    run() :-
        write("Разменять 10 монетами 1, 2, 5: ", ways(10, [1, 2, 5]), " способов\n"),
        write("Разменять 100 монетами 1, 5, 10, 25, 50: ", ways(100, [1, 5, 10, 25, 50]), " способов\n").

end implement main

goal
    console::runUtf8(main::run).
