implement main
    open core, stdio
class predicates
    bsort : (integer* L) -> integer* S.
    pass : (integer* L) -> integer* R.

clauses
    bsort(L) = L :-
        pass(L) = L,
        !.
    bsort(L) = bsort(pass(L)).

    pass([A, B | T]) = [B | pass([A | T])] :-
        A > B,
        !.
    pass([A | T]) = [A | pass(T)].
    pass([]) = [].

clauses
    run() :-
        write(bsort([5, 1, 4, 2, 8, 0]), "\n").

end implement main

goal
    console::runUtf8(main::run).
