implement main
    open core, stdio
class predicates
    windows : (integer* L, positive K) -> integer* M.

clauses
    windows(L, K) = [list::maximum(list::take(K, L)) | windows(T, K)] :-
        list::length(L) >= K,
        [_ | T] = L,
        !.
    windows(_, _) = [].

clauses
    run() :-
        write(windows([1, 3, -1, -3, 5, 3, 6, 7], 3), "\n").

end implement main

goal
    console::runUtf8(main::run).
