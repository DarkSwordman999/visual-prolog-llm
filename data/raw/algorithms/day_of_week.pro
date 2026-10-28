implement main
    open core, stdio
class predicates
    zeller : (integer D, integer M, integer Y) -> integer W.

clauses
    zeller(D, M, Y) = zeller(D, M + 12, Y - 1) :-
        M < 3,
        !.
    zeller(D, M, Y) = (D + 13 * (M + 1) div 5 + K + K div 4 + J div 4 + 5 * J) mod 7 :-
        K = Y mod 100,
        J = Y div 100.

clauses
    run() :-
        Names = ["суббота", "воскресенье", "понедельник", "вторник", "среда", "четверг", "пятница"],
        foreach tuple(D, M, Y) in [tuple(28, 10, 2026), tuple(1, 1, 2000), tuple(12, 4, 1961), tuple(29, 2, 2024)] do
            write(D, ".", M, ".", Y, " - ", list::nth(zeller(D, M, Y), Names), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
