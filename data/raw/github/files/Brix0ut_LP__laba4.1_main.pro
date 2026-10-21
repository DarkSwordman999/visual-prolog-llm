implement main
    open core, console, file

class facts - auditoria
    auditorium : (string, string, string, string, string, string, string).

class facts - addition
    i : integer := 0.

class predicates
    menu : ().
    process : (integer).
    error : ().
    printBD : ().
    queryBusy : ().

clauses
    printBD() :-
        auditorium(A, B, C, D, E, F, G),
        i := i + 1,
        console::write(i),
        nl,
        console::write("Номер: ", A),
        nl,
        write("Корпус: ", B, "\nДень: ", C, "\nЧас: ", D, "\nГрупа: ", E, "\nПредмет: ", F, "\nВикладач: ", G),
        nl,
        fail.
    printBD() :-
        i = 0,
        write("БД \"АУДИТОРІЯ\" пуста!!"),
        !.
    printBD() :-
        i := 0,
        succeed.

    queryBusy() :-
        write("\n========================================\n"),
        write("ВСІ АУДИТОРІЇ В БАЗІ ДАНИХ:\n"),
        write("========================================\n"),
        auditorium(A, B, C, D, E, F, G),
        write("Ауд.", A, " корп.", B, " ", C, " ", D, " гр.", E, " ", F, " ", G, "\n"),
        fail.
    queryBusy() :-
        write("========================================\n"),
        write("Натисніть Enter для продовження...\n"),
        _ = readChar(),
        !.

    error() :-
        write("Помилка. Введіть число від 1 до 6\n"),
        write("Натисніть Enter\n"),
        _ = readChar().

    process(1) :-
        write("Номер: "),
        A = readLine(),
        write("Корпус: "),
        B = readLine(),
        write("День: "),
        C = readLine(),
        write("Час: "),
        D = readLine(),
        write("Група: "),
        E = readLine(),
        write("Предмет: "),
        F = readLine(),
        write("Викладач: "),
        G = readLine(),
        assertz(auditorium(A, B, C, D, E, F, G)),
        write("\nДодано!\n"),
        _ = readChar(),
        !.

    process(2) :-
        write("Номер аудиторії: "),
        A = readLine(),
        retract(auditorium(A, _, _, _, _, _, _)),
        write("\nВидалено!\n"),
        _ = readChar(),
        !.

    process(3) :-
        i := 0,
        printBD(),
        _ = readChar(),
        !.

    process(4) :-
        file::save("auditoria.txt", auditoria),
        write("\nЗбережено в файл auditoria.txt\n"),
        _ = readChar(),
        !.

    process(5) :-
        queryBusy(),
        !.

    process(6) :-
        write("Вихід\n"),
        _ = readChar(),
        !.

    process(_) :-
        error.

    menu() :-
        std::repeat(),
        clearOutput(),
        write("========== БД АУДИТОРІЯ ==========\n"),
        write("1. Додати запис\n"),
        write("2. Видалити запис\n"),
        write("3. Вивести всі записи\n"),
        write("4. Зберегти в файл\n"),
        write("5. Показати всі аудиторії\n"),
        write("6. Вихід\n"),
        write("-----------------------------------\n"),
        write("Ваш вибір: "),
        N = read(),
        clearInput(),
        clearOutput(),
        process(N),
        N = 6,
        !.
    menu() :-
        succeed.

    run() :-
        menu(),
        !.

end implement main

goal
    console::runUtf8(main::run).
