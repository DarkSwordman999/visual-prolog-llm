implement main
    open core, stdio
class predicates
    isort : (integer* L) -> integer* S.
    insert : (integer X, integer* Sorted) -> integer* S.

clauses
    isort([]) = [].
    isort([H | T]) = insert(H, isort(T)).

    insert(X, []) = [X].
    insert(X, [H | T]) = [X, H | T] :-
        X <= H,
        !.
    insert(X, [H | T]) = [H | insert(X, T)].

clauses
    run() :-
        write(isort([5, 2, 9, 1, 5, 6, -3]), "\n").

end implement main

goal
    console::runUtf8(main::run).
