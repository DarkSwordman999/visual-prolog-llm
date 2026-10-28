implement main
    open core, stdio
class facts
    composite : (integer N).

class predicates
    sieve : (integer N).
    crossOut : (integer J, integer Step, integer N).

clauses
    sieve(N) :-
        foreach I = std::fromTo(2, N) and I * I <= N and not(composite(I)) do
            crossOut(I * I, I, N)
        end foreach.

    crossOut(J, _, N) :-
        J > N,
        !.
    crossOut(J, Step, N) :-
        if not(composite(J)) then
            assert(composite(J))
        end if,
        crossOut(J + Step, Step, N).

clauses
    run() :-
        N = 50,
        sieve(N),
        Primes = [P || P = std::fromTo(2, N), not(composite(P))],
        write("Простые до ", N, ": ", Primes, "\n").

end implement main

goal
    console::runUtf8(main::run).
