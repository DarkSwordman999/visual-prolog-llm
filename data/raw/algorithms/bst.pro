implement main
    open core, stdio
domains
    tree = empty; node(tree Left, integer Value, tree Right).

class predicates
    insert : (integer X, tree T) -> tree R.
    fromList : (integer* L, tree T) -> tree R.
    contains : (integer X, tree T) determ.
    inorder : (tree T) -> integer* L.
    height : (tree T) -> integer H.

clauses
    insert(X, empty) = node(empty, X, empty) :-
        !.
    insert(X, node(L, V, R)) = node(insert(X, L), V, R) :-
        X < V,
        !.
    insert(X, node(L, V, R)) = node(L, V, insert(X, R)) :-
        X > V,
        !.
    insert(_, T) = T.

    fromList([], T) = T.
    fromList([H | Rest], T) = fromList(Rest, insert(H, T)).

    contains(X, node(_, X, _)) :-
        !.
    contains(X, node(L, V, _)) :-
        X < V,
        !,
        contains(X, L).
    contains(X, node(_, _, R)) :-
        contains(X, R).

    inorder(empty) = [].
    inorder(node(L, V, R)) = list::append(inorder(L), [V | inorder(R)]).

    height(empty) = 0.
    height(node(L, _, R)) = 1 + math::max(height(L), height(R)).

clauses
    run() :-
        T = fromList([50, 30, 70, 20, 40, 60, 80, 35], empty),
        write("По возрастанию: ", inorder(T), "\n"),
        write("Высота: ", height(T), "\n"),
        foreach X in [40, 45] do
            write(X, if contains(X, T) then " есть в дереве" else " нет в дереве" end if, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
