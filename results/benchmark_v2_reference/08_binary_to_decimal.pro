implement main
    open core, stdio
class predicates
    toDecimal : (char* Bits, integer Acc) -> integer N.

clauses
    toDecimal([], Acc) = Acc.
    toDecimal(['1' | T], Acc) = toDecimal(T, Acc * 2 + 1) :-
        !.
    toDecimal([_ | T], Acc) = toDecimal(T, Acc * 2).

clauses
    run() :-
        write(toDecimal(string::toCharList("101101"), 0), "\n").

end implement main

goal
    console::runUtf8(main::run).
