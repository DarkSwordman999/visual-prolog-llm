implement main
    open core, stdio
class predicates
    numeral : (integer Value [out], string Symbol [out]) multi.
    roman : (integer N) -> string S.

clauses
    numeral(1000, "M").
    numeral(900, "CM").
    numeral(500, "D").
    numeral(400, "CD").
    numeral(100, "C").
    numeral(90, "XC").
    numeral(50, "L").
    numeral(40, "XL").
    numeral(10, "X").
    numeral(9, "IX").
    numeral(5, "V").
    numeral(4, "IV").
    numeral(1, "I").

    roman(N) = string::concat(S, roman(N - V)) :-
        N > 0,
        numeral(V, S),
        V <= N,
        !.
    roman(_) = "".

clauses
    run() :-
        foreach N in [4, 9, 14, 40, 1994, 2026, 3999] do
            write(N, " = ", roman(N), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
