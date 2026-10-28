implement main
    open core, stdio
class predicates
    top2 : (integer* L, integer First, integer Second) -> integer S.

clauses
    top2([], _, Second) = Second.
    top2([X | T], First, _) = top2(T, X, First) :-
        X > First,
        !.
    top2([X | T], First, Second) = top2(T, First, X) :-
        X < First,
        X > Second,
        !.
    top2([_ | T], First, Second) = top2(T, First, Second).

clauses
    run() :-
        L = [12, 35, 1, 10, 34, 35, 1],
        write("Второй максимум: ", top2(L, -1000000, -1000000), "\n").

end implement main

goal
    console::runUtf8(main::run).
