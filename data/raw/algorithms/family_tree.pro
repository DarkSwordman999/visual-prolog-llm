implement main
    open core, stdio
class facts
    parent : (string Parent, string Child).

class predicates
    grandparent : (string G, string C) nondeterm anyflow.
    sibling : (string A, string B) nondeterm (i,o).
    ancestor : (string A, string C) nondeterm (o,i).

clauses
    parent("Иван", "Пётр").
    parent("Мария", "Пётр").
    parent("Иван", "Анна").
    parent("Пётр", "Олег").
    parent("Пётр", "Ольга").
    parent("Анна", "Денис").

    grandparent(G, C) :-
        parent(G, P),
        parent(P, C).

    sibling(A, B) :-
        parent(P, A),
        parent(P, B),
        A <> B.

    ancestor(A, C) :-
        parent(A, C).
    ancestor(A, C) :-
        parent(P, C),
        ancestor(A, P).

clauses
    run() :-
        write("Внуки Ивана: ", list::removeDuplicates([C || grandparent("Иван", C)]), "\n"),
        write("Братья и сёстры Олега: ", list::removeDuplicates([B || sibling("Олег", B)]), "\n"),
        write("Двоюродные Олега: ", list::removeDuplicates([C || parent(P, "Олег"), sibling(P, U), parent(U, C)]), "\n"),
        write("Предки Дениса: ", list::removeDuplicates([A || ancestor(A, "Денис")]), "\n").

end implement main

goal
    console::runUtf8(main::run).
