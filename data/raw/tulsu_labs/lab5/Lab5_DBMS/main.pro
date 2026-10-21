implement main
    open core
    open stdio

domains
    % Список номеров признаков
    idList = integer*.
    % Правило в виде одного значения (нужно для пересортировки правил)
    ruleTuple = rt(string DbmsName, idList Conditions).

% БАЗА ЗНАНИЙ (признаки СУБД и правила классификации).
% Секция ИМЕНОВАННАЯ (knowledge) - только так ее можно сохранить
% в файл (file::save) и загрузить из файла (file::consult)
class facts - knowledge
    cond : (integer ID, string Description) nondeterm.
    kb_rule : (string DbmsName, idList Conditions) nondeterm.

% ПАМЯТЬ ДИАЛОГА (ответы пользователя в текущей консультации)
class facts - dialog
    cond_is : (integer ID, string Answer) nondeterm.

class predicates
    init_knowledge : ().
    load_knowledge : ().
    save_knowledge : ().
    sort_rules : ().
    find_dbms : (string Name [out]) determ.
    check_conditions : (idList Conditions) determ.
    validate : (integer ID) determ.
    get_valid_answer : (string Description) -> string.
    consultation : ().
    show_knowledge : ().
    add_dbms : ().
    delete_dbms : ().
    menu : ().

constants
    % Файл, в котором хранится база знаний
    kbFile : string = "C:\\Users\\user\\Downloads\\dbms_kb.txt".

clauses
    % Стартовое наполнение базы знаний (если файла еще нет)
    init_knowledge() :-
        assert(cond(1, "Это реляционная СУБД (язык запросов SQL)")),
        assert(cond(2, "Имеет открытый исходный код")),
        assert(cond(3, "Встраиваемая (работает без отдельного сервера)")),
        assert(cond(4, "Документо-ориентированная (хранит JSON-документы)")),
        assert(cond(5, "Хранит данные в оперативной памяти")),
        assert(cond(6, "Модель данных \"ключ - значение\"")),
        assert(cond(7, "Графовая модель данных")),
        assert(cond(8, "Колоночная СУБД для аналитики")),
        assert(cond(9, "Разработчик - компания Microsoft")),
        assert(cond(10, "Разработчик - компания Oracle")),
        assert(cond(11, "Российская разработка")),
        assert(cond(12, "Работает только как облачный сервис")),
        assert(kb_rule("Microsoft Access", [1, 3, 9])),
        assert(kb_rule("SQLite", [1, 2, 3])),
        assert(kb_rule("MySQL", [1, 2, 10])),
        assert(kb_rule("Redis", [2, 5, 6])),
        assert(kb_rule("ClickHouse", [2, 8, 11])),
        assert(kb_rule("Tarantool", [2, 5, 11])),
        assert(kb_rule("PostgreSQL", [1, 2])),
        assert(kb_rule("Oracle Database", [1, 10])),
        assert(kb_rule("Microsoft SQL Server", [1, 9])),
        assert(kb_rule("Postgres Pro", [1, 11])),
        assert(kb_rule("MongoDB", [2, 4])),
        assert(kb_rule("Neo4j", [2, 7])),
        assert(kb_rule("Amazon DynamoDB", [6, 12])).

    % Пытаемся прочитать базу знаний с диска; если файла нет -
    % наполняем базу стартовыми фактами и сразу сохраняем ее в файл
    load_knowledge() :-
        try
            retractFactDb(knowledge),
            file::consult(kbFile, knowledge),
            write("База знаний успешно ЗАГРУЖЕНА из файла ", kbFile, "\n")
        catch _ do
            write("Файл базы знаний не найден. Создаем новую базу знаний...\n"),
            retractFactDb(knowledge),
            init_knowledge(),
            save_knowledge()
        end try.

    % Записываем текущее состояние базы знаний в файл
    save_knowledge() :-
        file::saveUtf8(kbFile, knowledge),
        write("База знаний СОХРАНЕНА в файл ", kbFile, "\n").

    % Разрешение конфликта: более конкретные правила (с большим числом
    % признаков) должны проверяться раньше менее конкретных
    sort_rules() :-
        Rules = [rt(Name, Conds) || kb_rule(Name, Conds)],
        retractall(kb_rule(_, _)),
        foreach Len = std::downTo(12, 0) and rt(Name, Conds) in Rules and list::length(Conds) = Len do
            assert(kb_rule(Name, Conds))
        end foreach.

    % Проверка списка условий для конкретной СУБД
    check_conditions([]).
    check_conditions([Head | Tail]) :-
        validate(Head),
        check_conditions(Tail).

    % Логика проверки конкретного признака
    validate(ID) :-
        cond_is(ID, "1"),
        !. % Если уже отвечали "Да"
    validate(ID) :-
        cond_is(ID, "2"),
        !,
        fail. % Если уже отвечали "Нет"
    validate(ID) :-
        % Если еще не спрашивали - задаем вопрос
        cond(ID, Text),
        !,
        Ans = get_valid_answer(Text),
        assert(cond_is(ID, Ans)),
        validate(ID).

    % Безопасное чтение ответа пользователя (только 1 или 2)
    get_valid_answer(Desc) = Ans :-
        write(Desc, "? (1 - Да, 2 - Нет): "),
        InputStr = readLine(),
        if InputStr = "1" or InputStr = "2" then
            Ans = InputStr
        else
            write("Неверный ввод! Пожалуйста, используйте только 1 или 2.\n"),
            Ans = get_valid_answer(Desc)
        end if.

    % Механизм логического вывода: перебираем правила (откат),
    % пока условия одного из них не подтвердятся
    find_dbms(Name) :-
        kb_rule(Name, Conditions),
        check_conditions(Conditions),
        !.

    % Одна консультация
    consultation() :-
        retractFactDb(dialog), % очищаем ответы прошлой консультации
        write("\nЗагадайте СУБД и отвечайте на вопросы.\n\n"),
        if find_dbms(Name) then
            write("\nРезультат: Очевидно, это ", Name, "!\n")
        else
            write("\nРезультат: К сожалению, не удалось определить СУБД по базе знаний.\n")
        end if.

    % Вывод всей базы знаний на экран
    show_knowledge() :-
        write("\nПризнаки:\n"),
        foreach cond(ID, Text) do
            write("  ", ID, ". ", Text, "\n")
        end foreach,
        write("Правила (СУБД -> номера признаков):\n"),
        foreach kb_rule(Name, Conds) do
            write("  ", Name, " ", Conds, "\n")
        end foreach.

    % Добавление новой СУБД в базу знаний и сохранение в файл
    add_dbms() :-
        write("\nНазвание СУБД: "),
        Name = readLine(),
        write("Номера признаков в квадратных скобках, например [1,2,5]: "),
        Line = readLine(),
        try
            Conds = toTerm(idList, Line),
            retractall(kb_rule(Name, _)),
            assert(kb_rule(Name, Conds)),
            sort_rules(),
            write("СУБД ", Name, " добавлена в базу знаний.\n"),
            save_knowledge()
        catch _ do
            write("Неверный формат списка признаков.\n")
        end try.

    % Удаление СУБД из базы знаний и сохранение в файл
    delete_dbms() :-
        write("\nНазвание СУБД для удаления: "),
        Name = readLine(),
        if kb_rule(Name, _) then
            retractall(kb_rule(Name, _)),
            write("Запись '", Name, "' удалена из базы знаний.\n"),
            save_knowledge()
        else
            write("СУБД ", Name, " в базе знаний нет.\n")
        end if.

    % Меню (система пользовательского интерфейса)
    menu() :-
        write("\n1 - Консультация (определить СУБД)\n"),
        write("2 - Показать базу знаний\n"),
        write("3 - Добавить СУБД в базу знаний\n"),
        write("4 - Удалить СУБД из базы знаний\n"),
        write("0 - Выход\n"),
        write("Ваш выбор: "),
        Choice = readLine(),
        if Choice = "0" then
            succeed
        else
            if Choice = "1" then
                consultation()
            elseif Choice = "2" then
                show_knowledge()
            elseif Choice = "3" then
                add_dbms()
            elseif Choice = "4" then
                delete_dbms()
            else
                write("Неверный пункт меню.\n")
            end if,
            menu()
        end if.

    % Главная точка входа
    run() :-
        write("--- Экспертная система \"Системы управления БД\" ---\n\n"),
        load_knowledge(),
        menu(),
        save_knowledge(),
        nl,
        write("Нажмите Enter для выхода..."),
        _ = readLine().

end implement main

goal
    console::runUtf8(main::run).
