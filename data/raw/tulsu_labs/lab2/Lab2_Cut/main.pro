implement main
    open core
    open stdio

class facts
    % База данных студентов: имя и количество баллов
    student : (string Name, integer Score).

class predicates
    % Предикат принимает баллы (i) и возвращает оценку (o)
    get_mark : (integer Score, string Mark [out]).
    % Находит первого отличника (o) и останавливает поиск
    first_excellent : (string Name [out]) determ.

clauses
    % ФАКТЫ
    student("Иванов", 72).
    student("Петров", 91).
    student("Сидоров", 45).
    student("Смирнова", 88).

    % Метод отсечения: как только условие выполнено, ! запрещает
    % Прологу проверять остальные клаузы
    get_mark(Score, "отлично") :-
        Score >= 85,
        !.
    get_mark(Score, "хорошо") :-
        Score >= 70,
        !.
    get_mark(Score, "удовлетворительно") :-
        Score >= 50,
        !.
    get_mark(_, "неудовлетворительно").

    % Отсечение останавливает перебор фактов после первого найденного
    first_excellent(Name) :-
        student(Name, Score),
        Score >= 85,
        !.

    run() :-
        write("--- Метод отсечения (!) ---\n\n"),
        % Запрос 1: оценка по баллам, введенным пользователем
        write("Введите количество баллов: "),
        InputStr = readLine(),
        Score = toTerm(integer, InputStr),
        get_mark(Score, Mark),
        write("Оценка: ", Mark, "\n\n"),
        % Запрос 2: оценки всех студентов из базы
        write("Оценки студентов:\n"),
        foreach student(Name, Points) do
            get_mark(Points, StudentMark),
            write("- ", Name, ", баллы: ", Points, ", оценка: ", StudentMark, "\n")
        end foreach,
        nl,
        % Запрос 3: первый отличник в базе
        if first_excellent(Best) then
            write("Первый найденный отличник: ", Best, "\n")
        else
            write("Отличников нет.\n")
        end if,
        nl,
        write("Нажмите любую клавишу для выхода..."),
        _ = readChar().

end implement main

goal
    console::runUtf8(main::run).
