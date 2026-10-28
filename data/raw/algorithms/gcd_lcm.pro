implement main
    open core, stdio
class predicates
    gcd : (integer A, integer B) -> integer G.
    lcm : (integer A, integer B) -> integer L.

clauses
    gcd(A, 0) = A :-
        !.
    gcd(A, B) = gcd(B, A mod B).

    lcm(A, B) = A div gcd(A, B) * B.

clauses
    run() :-
        write("НОД(48, 18) = ", gcd(48, 18), "\n"),
        write("НОД(17, 5) = ", gcd(17, 5), "\n"),
        write("НОК(4, 6) = ", lcm(4, 6), "\n"),
        write("НОК(21, 6) = ", lcm(21, 6), "\n").

end implement main

goal
    console::runUtf8(main::run).
