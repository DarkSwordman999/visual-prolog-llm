implement main
    open core, stdio
class predicates
    comb : (integer K, string* L) -> string* C nondeterm.

clauses
    comb(0, _) = [] :-
        !.
    comb(K, [H | T]) = [H | comb(K - 1, T)].
    comb(K, [_ | T]) = comb(K, T).

clauses
    run() :-
        foreach C = comb(2, ["а", "б", "в", "г"]) do
            write(C, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
