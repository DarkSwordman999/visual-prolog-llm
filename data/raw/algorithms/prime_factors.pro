implement main
    open core, stdio
class predicates
    factors : (integer N, integer D) -> integer* Factors.

clauses
    factors(1, _) = [] :-
        !.
    factors(N, D) = [N] :-
        D * D > N,
        !.
    factors(N, D) = [D | factors(N div D, D)] :-
        N mod D = 0,
        !.
    factors(N, D) = factors(N, D + 1).

clauses
    run() :-
        foreach N in [12, 97, 360, 1001] do
            write(N, " = ", factors(N, 2), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
