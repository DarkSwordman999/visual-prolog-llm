implement main
    open core, stdio
class predicates
    merge : (integer* A, integer* B) -> integer* C.

clauses
    merge([], B) = B :-
        !.
    merge(A, []) = A :-
        !.
    merge([X | A], [Y | B]) = [X | merge(A, [Y | B])] :-
        X <= Y,
        !.
    merge(A, [Y | B]) = [Y | merge(A, B)] :-
        !.
    merge(A, B) = list::append(A, B).

clauses
    run() :-
        write(merge([1, 4, 6, 9], [2, 3, 7, 10, 11]), "\n").

end implement main

goal
    console::runUtf8(main::run).
