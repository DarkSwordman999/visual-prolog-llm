implement main
    open core, stdio
class predicates
    gcd : (integer A, integer B) -> integer G.

clauses
    gcd(A, 0) = A :-
        !.
    gcd(A, B) = gcd(B, A mod B).

clauses
    run() :-
        L = list::fold([I || I = std::fromTo(1, 10)], { (I, Acc) = Acc div gcd(Acc, I) * I }, 1),
        write(L, "\n").

end implement main

goal
    console::runUtf8(main::run).
