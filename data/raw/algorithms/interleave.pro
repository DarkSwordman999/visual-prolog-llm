implement main
    open core, stdio
class predicates
    interleave : (integer* A, integer* B) -> integer* C.

clauses
    interleave([], B) = B.
    interleave([H | T], B) = [H | interleave(B, T)].

clauses
    run() :-
        write(interleave([1, 3, 5, 7], [2, 4, 6]), "\n"),
        write(interleave([1], [2, 3, 4]), "\n").

end implement main

goal
    console::runUtf8(main::run).
