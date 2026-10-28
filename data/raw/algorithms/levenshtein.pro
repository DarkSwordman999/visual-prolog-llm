implement main
    open core, stdio
class predicates
    distance : (string A, string B) -> integer D.
    rows : (char* A, char* B, integer* Prev, integer I) -> integer* Row.
    cells : (char C, char* B, integer* Prev, integer Left) -> integer* Row.
    cost : (char X, char Y) -> integer C.

clauses
    distance(A, B) = list::nth(list::length(Last) - 1, Last) :-
        BL = string::toCharList(B),
        First = [I || I = std::fromTo(0, list::length(BL))],
        Last = rows(string::toCharList(A), BL, First, 1).

    rows([], _, Prev, _) = Prev.
    rows([C | Cs], B, Prev, I) = rows(Cs, B, [I | cells(C, B, Prev, I)], I + 1).

    cells(C, [D | Ds], [Diag, Up | Ps], Left) = [V | cells(C, Ds, [Up | Ps], V)] :-
        !,
        V = math::min(Up + 1, Left + 1, Diag + cost(C, D)).
    cells(_, _, _, _) = [].

    cost(X, X) = 0 :-
        !.
    cost(_, _) = 1.

clauses
    run() :-
        foreach tuple(A, B) in [tuple("котик", "скотина"), tuple("kitten", "sitting"), tuple("пролог", "пролог"), tuple("", "abc")] do
            write("\"", A, "\" -> \"", B, "\": ", distance(A, B), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
