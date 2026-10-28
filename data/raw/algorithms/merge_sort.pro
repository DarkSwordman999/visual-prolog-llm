implement main
    open core, stdio
class predicates
    msort : (integer* L) -> integer* S.
    halve : (integer* L, integer* A [out], integer* B [out]).
    merge : (integer* A, integer* B) -> integer* C.

clauses
    msort([]) = [] :-
        !.
    msort([X]) = [X] :-
        !.
    msort(L) = merge(msort(A), msort(B)) :-
        halve(L, A, B).

    halve([], [], []).
    halve([H | T], [H | B], A) :-
        halve(T, A, B).

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
        write(msort([38, 27, 43, 3, 9, 82, 10]), "\n").

end implement main

goal
    console::runUtf8(main::run).
