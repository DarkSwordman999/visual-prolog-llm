implement main
    open core, stdio
class facts
    arc : (integer From, integer To).

class predicates
    reach : (integer From, integer To, integer* Visited) determ.
    hasCycle : () determ.

clauses
    arc(1, 2).
    arc(2, 3).
    arc(3, 4).
    arc(4, 2).
    arc(5, 6).

    reach(From, To, _) :-
        arc(From, To),
        !.
    reach(From, To, Visited) :-
        arc(From, Next),
        not(list::isMember(Next, Visited)),
        reach(Next, To, [Next | Visited]),
        !.

    hasCycle() :-
        arc(V, _),
        reach(V, V, [V]),
        !.

clauses
    run() :-
        write(if hasCycle() then "Цикл есть" else "Цикла нет" end if, "\n"),
        write("Вершины в циклах: ", list::removeDuplicates([V || arc(V, _), reach(V, V, [V])]), "\n").

end implement main

goal
    console::runUtf8(main::run).
