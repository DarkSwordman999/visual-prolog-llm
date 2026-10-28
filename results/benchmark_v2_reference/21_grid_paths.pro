implement main
    open core, stdio
class predicates
    paths : (integer R, integer C) -> integer N.

clauses
    paths(0, _) = 1 :-
        !.
    paths(_, 0) = 1 :-
        !.
    paths(R, C) = paths(R - 1, C) + paths(R, C - 1).

clauses
    run() :-
        write(paths(3, 3), "\n").

end implement main

goal
    console::runUtf8(main::run).
