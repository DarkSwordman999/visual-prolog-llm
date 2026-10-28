implement main
    open core, stdio
class facts
    edge : (string From, string To).

class predicates
    adjacent : (string X, string Y [out]) nondeterm.
    path : (string From, string To, string* Visited) -> string* Path nondeterm.

clauses
    edge("A", "B").
    edge("A", "C").
    edge("B", "D").
    edge("C", "D").
    edge("D", "E").
    edge("B", "C").

    adjacent(X, Y) :-
        edge(X, Y).
    adjacent(X, Y) :-
        edge(Y, X).

    path(X, X, _) = [X].
    path(X, Y, Visited) = [X | path(Z, Y, [Z | Visited])] :-
        X <> Y,
        adjacent(X, Z),
        not(list::isMember(Z, Visited)).

clauses
    run() :-
        foreach P = path("A", "E", ["A"]) do
            write(P, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
