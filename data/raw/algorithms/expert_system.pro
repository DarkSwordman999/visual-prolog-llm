implement main
    open core, stdio
class facts
    has : (string Feature).

class predicates
    isMammal : () determ.
    isBird : () determ.
    animal : (string Name [out]) determ.
    identify : (string* Features).

clauses
    isMammal() :-
        has("шерсть"),
        !.
    isMammal() :-
        has("молоко"),
        !.

    isBird() :-
        has("перья"),
        !.
    isBird() :-
        has("летает"),
        has("откладывает яйца"),
        !.

    animal("тигр") :-
        isMammal(),
        has("хищник"),
        has("полосы"),
        !.
    animal("гепард") :-
        isMammal(),
        has("хищник"),
        has("пятна"),
        !.
    animal("зебра") :-
        isMammal(),
        has("копыта"),
        has("полосы"),
        !.
    animal("пингвин") :-
        isBird(),
        has("плавает"),
        not(has("летает")),
        !.
    animal("орёл") :-
        isBird(),
        has("хищник"),
        has("летает"),
        !.

    identify(Features) :-
        retractAll(has(_)),
        foreach F in Features do
            assert(has(F))
        end foreach,
        if animal(Name) then
            write(Features, " -> ", Name, "\n")
        else
            write(Features, " -> не удалось определить\n")
        end if.

clauses
    run() :-
        identify(["шерсть", "хищник", "полосы"]),
        identify(["молоко", "копыта", "полосы"]),
        identify(["перья", "плавает"]),
        identify(["перья", "хищник", "летает"]),
        identify(["чешуя"]).

end implement main

goal
    console::runUtf8(main::run).
