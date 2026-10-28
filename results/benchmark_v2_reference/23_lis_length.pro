implement main
    open core, stdio
class predicates
    lis : (integer* L, integer Last) -> integer N.

clauses
    lis([], _) = 0.
    lis([H | T], Last) = math::max(1 + lis(T, H), lis(T, Last)) :-
        H > Last,
        !.
    lis([_ | T], Last) = lis(T, Last).

clauses
    run() :-
        write(lis([10, 9, 2, 5, 3, 7, 101, 18], -1000000), "\n").

end implement main

goal
    console::runUtf8(main::run).
