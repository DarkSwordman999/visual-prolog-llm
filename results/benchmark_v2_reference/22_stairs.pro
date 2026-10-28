implement main
    open core, stdio
class predicates
    ways : (integer N, integer A, integer B) -> integer W.

clauses
    ways(0, A, _) = A :-
        !.
    ways(N, A, B) = ways(N - 1, B, A + B).

clauses
    run() :-
        write(ways(10, 1, 1), "\n").

end implement main

goal
    console::runUtf8(main::run).
