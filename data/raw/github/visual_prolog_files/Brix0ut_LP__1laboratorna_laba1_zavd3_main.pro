implement main
    open core, console

class facts
    kurort : (string, string, integer).

class predicates
    potyagu_cost : (string [out], integer) nondeterm.
    potyagu_loc : (string [out], string) nondeterm.
    potyagu_all : (string [out], string, integer) nondeterm.

clauses
    kurort("Териберка", "Баренцеве море", 1200).
    kurort("Снігова долина", "Карпати", 800).
    kurort("Морське око", "Баренцеве море", 900).
    kurort("Сонячний берег", "Чорне море", 1500).
    kurort("Північне сяйво", "Баренцеве море", 2000).

    potyagu_cost(Name, MaxCost) :-
        kurort(Name, _, Cost),
        Cost <= MaxCost.

    potyagu_loc(Name, Location) :-
        kurort(Name, Location, _).

    potyagu_all(Name, Location, MaxCost) :-
        kurort(Name, Location, Cost),
        Cost <= MaxCost.

    run() :-
        nl,
        write("--- Пошук за вартістю (бюджет до 1000) ---"),
        nl,
        potyagu_cost(Name1, 1000),
        write("Підходить курорт: ", Name1),
        nl,
        fail
        or
        nl,
        write("--- Пошук за розташуванням (Баренцеве море) ---"),
        nl,
        potyagu_loc(Name2, "Баренцеве море"),
        write("Підходить курорт: ", Name2),
        nl,
        fail
        or
        nl,
        write("--- Пошук за всіма умовами (Баренцеве море, бюджет до 1000) ---"),
        nl,
        potyagu_all(Name3, "Баренцеве море", 1000),
        write("Підходить ідеальний курорт: ", Name3),
        nl,
        fail
        or
        _ = readChar().

end implement main

goal
    console::runUtf8(main::run).
