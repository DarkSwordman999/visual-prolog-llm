implement main
    open core, stdio
class facts
    moves : integer := 0.

class predicates
    hanoi : (integer N, string From, string To, string Via).

clauses
    hanoi(0, _, _, _) :-
        !.
    hanoi(N, From, To, Via) :-
        hanoi(N - 1, From, Via, To),
        moves := moves + 1,
        write(moves, ". Диск ", N, ": ", From, " -> ", To, "\n"),
        hanoi(N - 1, Via, To, From).

clauses
    run() :-
        hanoi(3, "A", "C", "B"),
        write("Всего ходов: ", moves, "\n").

end implement main

goal
    console::runUtf8(main::run).
