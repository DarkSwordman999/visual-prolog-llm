implement main
    open core, stdio
class predicates
    count : (integer X, integer* L) -> integer N.

clauses
    count(_, []) = 0.
    count(X, [X | T]) = 1 + count(X, T) :-
        !.
    count(X, [_ | T]) = count(X, T).

clauses
    run() :-
        L = [1, 2, 1, 3, 1, 2],
        foreach X in [1, 2, 3, 4] do
            write(X, " встречается ", count(X, L), " раз(а)\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
