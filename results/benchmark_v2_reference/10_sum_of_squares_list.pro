implement main
    open core, stdio
class predicates
    sumSq : (integer* L) -> integer S.

clauses
    sumSq([]) = 0.
    sumSq([H | T]) = H * H + sumSq(T).

clauses
    run() :-
        write(sumSq([1, 2, 3, 4]), "\n").

end implement main

goal
    console::runUtf8(main::run).
