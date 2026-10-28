implement main
    open core, stdio
class predicates
    reverseNum : (integer N, integer Acc) -> integer R.

clauses
    reverseNum(0, Acc) = Acc :-
        !.
    reverseNum(N, Acc) = reverseNum(N div 10, Acc * 10 + N mod 10).

clauses
    run() :-
        foreach N in [1234, 1200, 12321] do
            R = reverseNum(N, 0),
            write(N, " -> ", R),
            if R = N then
                write(" (палиндром)")
            end if,
            write("\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
