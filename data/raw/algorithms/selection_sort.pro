implement main
    open core, stdio
class predicates
    ssort : (integer* L) -> integer* S.
    minAcc : (integer* L, integer M) -> integer Min.
    removeFirst : (integer X, integer* L) -> integer* R.

clauses
    ssort([]) = [].
    ssort([H | T]) = [M | ssort(removeFirst(M, [H | T]))] :-
        M = minAcc(T, H).

    minAcc([], M) = M.
    minAcc([H | T], M) = minAcc(T, H) :-
        H < M,
        !.
    minAcc([_ | T], M) = minAcc(T, M).

    removeFirst(_, []) = [].
    removeFirst(X, [X | T]) = T :-
        !.
    removeFirst(X, [H | T]) = [H | removeFirst(X, T)].

clauses
    run() :-
        write(ssort([64, 25, 12, 22, 11, 25]), "\n").

end implement main

goal
    console::runUtf8(main::run).
