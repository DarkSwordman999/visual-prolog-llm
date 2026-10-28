implement main
    open core, stdio
class predicates
    product : (integer N) -> integer P.

clauses
    product(N) = N :-
        N < 10,
        !.
    product(N) = N mod 10 * product(N div 10).

clauses
    run() :-
        write(product(2345), "\n").

end implement main

goal
    console::runUtf8(main::run).
