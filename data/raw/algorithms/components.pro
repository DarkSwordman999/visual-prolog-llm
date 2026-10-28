implement main
    open core, stdio
class facts
    edge : (integer A, integer B).

class predicates
    adjacent : (integer X, integer Y [out]) nondeterm.
    components : (integer* Nodes, integer* Seen) -> integer Count.
    reach : (integer* Stack, integer* Seen) -> integer* NewSeen.

clauses
    edge(1, 2).
    edge(2, 3).
    edge(4, 5).
    edge(6, 7).
    edge(7, 8).
    edge(8, 6).

    adjacent(X, Y) :-
        edge(X, Y).
    adjacent(X, Y) :-
        edge(Y, X).

    components([], _) = 0.
    components([N | T], Seen) = components(T, Seen) :-
        list::isMember(N, Seen),
        !.
    components([N | T], Seen) = 1 + components(T, reach([N], Seen)).

    reach([], Seen) = Seen.
    reach([N | T], Seen) = reach(T, Seen) :-
        list::isMember(N, Seen),
        !.
    reach([N | T], Seen) = reach(list::append([M || adjacent(N, M)], T), [N | Seen]).

clauses
    run() :-
        Nodes = [1, 2, 3, 4, 5, 6, 7, 8, 9],
        write("Компонент связности: ", components(Nodes, []), "\n").

end implement main

goal
    console::runUtf8(main::run).
