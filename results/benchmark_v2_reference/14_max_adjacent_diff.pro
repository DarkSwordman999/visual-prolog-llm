implement main
    open core, stdio
class predicates
    maxDiff : (integer* L, integer Best) -> integer M.

clauses
    maxDiff([A, B | T], Best) = maxDiff([B | T], math::max(Best, D)) :-
        !,
        D = if A > B then A - B else B - A end if.
    maxDiff(_, Best) = Best.

clauses
    run() :-
        write(maxDiff([1, 7, 3, 10, 2], 0), "\n").

end implement main

goal
    console::runUtf8(main::run).
