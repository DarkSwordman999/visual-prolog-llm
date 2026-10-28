implement main
    open core, stdio
class facts
    before : (string A, string B).

class predicates
    ready : (string Task, string* Done) determ.
    topo : (string* Left, string* Done) -> string* Order determ.

clauses
    before("Анализ", "Проектирование").
    before("Проектирование", "Программирование").
    before("Проектирование", "Тест-план").
    before("Программирование", "Тестирование").
    before("Тест-план", "Тестирование").
    before("Тестирование", "Внедрение").

    ready(T, Done) :-
        not((before(P, T), not(list::isMember(P, Done)))).

    topo([], Done) = list::reverse(Done) :-
        !.
    topo(Left, Done) = topo(list::remove(Left, T), [T | Done]) :-
        T in Left,
        ready(T, Done),
        !.

clauses
    run() :-
        Tasks = ["Внедрение", "Тестирование", "Тест-план", "Программирование", "Проектирование", "Анализ"],
        if Order = topo(Tasks, []) then
            foreach T in Order do
                write(T, "\n")
            end foreach
        else
            write("В зависимостях есть цикл\n")
        end if.

end implement main

goal
    console::runUtf8(main::run).
