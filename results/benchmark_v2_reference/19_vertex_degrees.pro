implement main
    open core, stdio
class facts
    edge : (string A, string B).

class predicates
    degree : (string V) -> integer D.

clauses
    edge("a", "b").
    edge("a", "c").
    edge("b", "c").
    edge("c", "d").

    degree(V) = list::length([1 || edge(V, _)]) + list::length([1 || edge(_, V)]).

clauses
    run() :-
        foreach V in ["a", "b", "c", "d"] do
            write(degree(V), " ")
        end foreach,
        write("\n").

end implement main

goal
    console::runUtf8(main::run).
