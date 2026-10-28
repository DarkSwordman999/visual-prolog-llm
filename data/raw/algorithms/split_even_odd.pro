implement main
    open core, stdio
class predicates
    split : (integer* L, integer* Even [out], integer* Odd [out]).

clauses
    split([], [], []).
    split([H | T], [H | E], O) :-
        H mod 2 = 0,
        !,
        split(T, E, O).
    split([H | T], E, [H | O]) :-
        split(T, E, O).

clauses
    run() :-
        split([1, 2, 3, 4, 5, 6, 7], Even, Odd),
        write("Чётные: ", Even, "\n"),
        write("Нечётные: ", Odd, "\n").

end implement main

goal
    console::runUtf8(main::run).
