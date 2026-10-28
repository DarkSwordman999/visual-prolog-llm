implement main
    open core, stdio
class predicates
    lcs : (string A, string B) -> integer N.
    rows : (char* A, char* B, integer* Prev) -> integer* Row.
    cells : (char C, char* B, integer* Prev, integer Left) -> integer* Row.

clauses
    lcs(A, B) = list::nth(list::length(Last) - 1, Last) :-
        BL = string::toCharList(B),
        Last = rows(string::toCharList(A), BL, [0 || _ = std::fromTo(0, list::length(BL))]).

    rows([], _, Prev) = Prev.
    rows([C | Cs], B, Prev) = rows(Cs, B, [0 | cells(C, B, Prev, 0)]).

    cells(C, [D | Ds], [Diag, Up | Ps], Left) = [V | cells(C, Ds, [Up | Ps], V)] :-
        !,
        V = if C = D then Diag + 1 else math::max(Up, Left) end if.
    cells(_, _, _, _) = [].

clauses
    run() :-
        foreach tuple(A, B) in [tuple("ABCBDAB", "BDCABA"), tuple("пролог", "логика"), tuple("abc", "xyz")] do
            write(A, " / ", B, ": ", lcs(A, B), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
