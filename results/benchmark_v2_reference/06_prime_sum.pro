implement main
    open core, stdio
class predicates
    isPrime : (integer N) determ.

clauses
    isPrime(N) :-
        N >= 2,
        not((D = std::fromTo(2, N - 1), D * D <= N, N mod D = 0)).

clauses
    run() :-
        write(list::sum([P || P = std::fromTo(2, 49), isPrime(P)]), "\n").

end implement main

goal
    console::runUtf8(main::run).
