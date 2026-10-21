implement main
    open core
    open stdio

clauses
    run() :-
        write("--- Вычисление куба числа ---\n\n"),
        write("Введите целое число: "),
        % Читаем строку, введенную пользователем
        InputStr = readLine(),
        % Преобразуем строку в целое число
        N = toTerm(integer, InputStr),
        % Вычисляем куб числа
        Cube = N * N * N,
        nl,
        write("Куб числа ", N, " равен ", Cube, "\n\n"),
        write("Нажмите любую клавишу для выхода..."),
        _ = readChar().

end implement main

goal
    console::runUtf8(main::run).
