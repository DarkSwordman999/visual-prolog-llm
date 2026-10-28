implement main
    open core, stdio
class predicates
    reverse : (integer* L) -> integer* R.
    revAcc : (integer* L, integer* Acc) -> integer* R.

clauses
    reverse(L) = revAcc(L, []).

    revAcc([], Acc) = Acc.
    revAcc([H | T], Acc) = revAcc(T, [H | Acc]).

clauses
    run() :-
        write(reverse([1, 2, 3, 4, 5]), "\n"),
        write(reverse([]), "\n").

end implement main

goal
    console::runUtf8(main::run).
