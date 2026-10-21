implement main
    open core
    open stdio

domains
    % Объявляем домен списка символов
    charList = char*.

class predicates
    % Преобразует список символов (i) в строку (o)
    list_to_string : (charList List, string Str [out]).
    % Построчно читает списки из входного файла и пишет строки в выходной
    process : (inputStream In, outputStream Out).

clauses
    % Базовый случай: пустой список превращается в пустую строку
    list_to_string([], "") :-
        !.
    % Шаг рекурсии: хвост превращаем в строку, а голову
    % (символ) приписываем в ее начало
    list_to_string([Head | Tail], Str) :-
        list_to_string(Tail, TailStr),
        Str = string::concat(string::charToString(Head), TailStr).

    % Пока файл не закончился: читаем строку, преобразуем ее в список
    % символов, список - в строку, результат записываем в выходной файл
    process(In, Out) :-
        if not(In:endOfStream()) then
            Line = In:readLine(),
            Chars = toTerm(charList, Line),
            list_to_string(Chars, Str),
            write("Прочитан список: ", Line, "  ->  строка: ", Str, "\n"),
            Out:write(Str, "\n"),
            process(In, Out) % Рекурсивный вызов для следующей строки
        end if.

    run() :-
        write("--- Преобразование списков символов из файла в строки ---\n\n"),
        % Открываем входной файл для чтения
        In = inputStream_file::openFileUtf8("C:\\input.txt"),
        % Создаем новый файл для записи результата
        Out = outputStream_file::createUtf8("C:\\output.txt"),
        process(In, Out),
        % Обязательно закрываем оба потока
        In:close(),
        Out:close(),
        write("\nРезультат записан в файл C:\\output.txt\n\n"),
        write("Нажмите любую клавишу для выхода..."),
        _ = readChar().

end implement main

goal
    console::runUtf8(main::run).
