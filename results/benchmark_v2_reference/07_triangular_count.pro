implement main
    open core, stdio
class predicates
    count : (integer K, integer Sum) -> integer N.

clauses
    count(K, Sum) = 0 :-
        Sum + K >= 100,
        !.
    count(K, Sum) = 1 + count(K + 1, Sum + K).

clauses
    run() :-
        write(count(1, 0), "\n").

end implement main

goal
    console::runUtf8(main::run).
