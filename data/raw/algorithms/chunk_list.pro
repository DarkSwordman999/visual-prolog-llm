implement main
    open core, stdio
class predicates
    chunks : (integer* L, positive K) -> integer** C.

clauses
    chunks([], _) = [] :-
        !.
    chunks(L, K) = [list::take(K, L) | chunks(list::drop(K, L), K)].

clauses
    run() :-
        L = [I || I = std::fromTo(1, 10)],
        write(chunks(L, 3), "\n"),
        write(chunks(L, 5), "\n").

end implement main

goal
    console::runUtf8(main::run).
