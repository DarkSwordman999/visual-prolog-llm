implement main
    open core, stdio
class predicates
    gcd : (integer A, integer B) -> integer G.
    gcdList : (integer* L, integer Acc) -> integer G.

clauses
    gcd(A, 0) = A :-
        !.
    gcd(A, B) = gcd(B, A mod B).

    gcdList([], Acc) = Acc.
    gcdList([H | T], Acc) = gcdList(T, gcd(Acc, H)).

clauses
    run() :-
        foreach L in [[12, 18, 24], [17, 34, 51], [7, 13]] do
            write("НОД", L, " = ", gcdList(L, 0), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
