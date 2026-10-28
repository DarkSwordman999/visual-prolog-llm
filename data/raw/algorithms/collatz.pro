implement main
    open core, stdio
class predicates
    steps : (integer N) -> integer S.

clauses
    steps(1) = 0 :-
        !.
    steps(N) = 1 + steps(N div 2) :-
        N mod 2 = 0,
        !.
    steps(N) = 1 + steps(3 * N + 1).

clauses
    run() :-
        foreach N in [1, 6, 7, 27] do
            write(N, ": ", steps(N), " шагов\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
