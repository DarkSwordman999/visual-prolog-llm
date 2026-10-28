implement main
    open core, stdio
class facts
    edge : (integer From, integer To).

class predicates
    adjacent : (integer X, integer Y [out]) nondeterm.
    bfs : (integer** Queue, integer Goal, integer* Visited) -> integer* Path determ.

clauses
    edge(1, 2).
    edge(1, 3).
    edge(2, 4).
    edge(3, 4).
    edge(4, 5).
    edge(5, 6).
    edge(3, 6).
    edge(6, 7).

    adjacent(X, Y) :-
        edge(X, Y).
    adjacent(X, Y) :-
        edge(Y, X).

    bfs([[Goal | Rest] | _], Goal, _) = list::reverse([Goal | Rest]) :-
        !.
    bfs([[Node | Rest] | Queue], Goal, Visited) = bfs(list::append(Queue, New), Goal, list::append(Visited, Next)) :-
        Next = list::removeDuplicates([N || adjacent(Node, N), not(list::isMember(N, Visited))]),
        New = [[N, Node | Rest] || N in Next].

clauses
    run() :-
        foreach Goal in [5, 7, 2] do
            if P = bfs([[1]], Goal, [1]) then
                write("Из 1 в ", Goal, ": ", P, ", рёбер: ", list::length(P) - 1, "\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
