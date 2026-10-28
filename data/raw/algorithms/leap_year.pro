implement main
    open core, stdio
class predicates
    isLeap : (integer Year) determ.

clauses
    isLeap(Y) :-
        Y mod 400 = 0,
        !.
    isLeap(Y) :-
        Y mod 4 = 0,
        Y mod 100 <> 0.

clauses
    run() :-
        write("Введите год: "),
        Y = toTerm(integer, readLine()),
        if isLeap(Y) then
            write(Y, " - високосный\n")
        else
            write(Y, " - не високосный\n")
        end if,
        foreach T in [1900, 2000, 2024, 2026] do
            write(T, if isLeap(T) then " да" else " нет" end if, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
