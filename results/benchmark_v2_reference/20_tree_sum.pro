implement main
    open core, stdio
domains
    tree = empty; node(tree Left, integer Value, tree Right).

class predicates
    sum : (tree T) -> integer S.

clauses
    sum(empty) = 0.
    sum(node(L, V, R)) = sum(L) + V + sum(R).

clauses
    run() :-
        T = node(node(empty, 2, empty), 5, node(node(empty, 6, empty), 8, empty)),
        write(sum(T), "\n").

end implement main

goal
    console::runUtf8(main::run).
