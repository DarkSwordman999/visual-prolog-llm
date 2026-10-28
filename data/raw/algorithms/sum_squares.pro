implement main
    open core, stdio
class predicates
    loopSum : (integer N) -> integer S.
    formula : (integer N) -> integer S.

clauses
    loopSum(N) = list::sum([I * I || I = std::fromTo(1, N)]).

    formula(N) = N * (N + 1) * (2 * N + 1) div 6.

clauses
    run() :-
        foreach N in [1, 10, 100] do
            write("N = ", N, ": циклом ", loopSum(N), ", по формуле ", formula(N), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
