implement main
    open core, console

class facts
    female : (string).
    male : (string).
    ancestor : (string, string).

class predicates
    married : (string, string) nondeterm (o,o) (i,o) (o,i) (i,i).
    sister : (string, string) nondeterm (o,o) (i,o) (o,i) (i,i).
    svoyachka : (string, string) nondeterm (o,o) (i,o) (o,i) (i,i).
    granddaughter : (string, string) nondeterm (o,o) (i,o) (o,i) (i,i).

clauses
    male("Ivan").
    male("Oleg").
    male("Petro").
    female("Anna").
    female("Vira").
    female("Daria").
    female("Alla").
    female("Nina").

    ancestor("Ivan", "Oleg").
    ancestor("Anna", "Oleg").
    ancestor("Ivan", "Nina").
    ancestor("Anna", "Nina").

    ancestor("Petro", "Vira").
    ancestor("Petro", "Daria").

    ancestor("Oleg", "Alla").
    ancestor("Vira", "Alla").

    married(Person1, Person2) :-
        ancestor(Person1, Child),
        ancestor(Person2, Child),
        Person1 <> Person2.

    sister(Sister, Person) :-
        female(Sister),
        ancestor(Parent, Sister),
        ancestor(Parent, Person),
        Sister <> Person.

    svoyachka(Svoyachka, Husband) :-
        male(Husband),
        married(Husband, Wife),
        female(Wife),
        sister(Svoyachka, Wife).

    granddaughter(Granddaughter, Grandparent) :-
        female(Granddaughter),
        ancestor(Grandparent, Parent),
        ancestor(Parent, Granddaughter).

    run() :-
        nl,
        write("Одружені: "),
        nl,
        married(P1, P2),
        write(P1, " та ", P2),
        nl,
        fail
        or
        nl,
        write("Сестри: "),
        nl,
        sister(S, P),
        write(S, " є сестрою для ", P),
        nl,
        fail
        or
        nl,
        write("Своячки: "),
        nl,
        svoyachka(Sv, H),
        write(Sv, " є своячкою для ", H),
        nl,
        fail
        or
        nl,
        write("Онучки: "),
        nl,
        granddaughter(Gd, Gp),
        write(Gd, " є онучкою для ", Gp),
        nl,
        fail
        or
        _ = readChar().

end implement main

goal
    console::runUtf8(main::run).
