implement main
    open core
    open stdio

domains
    % Объявляем домен списка символов
    charList = char*.

class predicates
    % Выводит элементы списка через пробел
    print_list : (charList List).
    % Преобразует список символов (i) в строку (o)
    list_to_string : (charList List, string Str [out]).

clauses
    % Базовый случай: пустой список - выводить нечего
    print_list([]) :-
        !.
    % Выводим голову и рекурсивно обрабатываем хвост
    print_list([Head | Tail]) :-
        write(Head, " "),
        print_list(Tail).

    % Базовый случай: пустой список превращается в пустую строку
    list_to_string([], "") :-
        !.
    % Шаг рекурсии: хвост превращаем в строку, а голову
    % (символ) приписываем в ее начало
    list_to_string([Head | Tail], Str) :-
        list_to_string(Tail, TailStr),
        Str = string::concat(string::charToString(Head), TailStr).

    run() :-
        write("--- Преобразование списка символов в строку ---\n\n"),
        Chars = ['П', 'р', 'о', 'л', 'о', 'г'],
        write("Список символов: "),
        print_list(Chars),
        nl,
        list_to_string(Chars, Str),
        write("Полученная строка: ", Str, "\n"),
        write("Длина строки: ", string::length(Str), "\n\n"),
        write("Нажмите любую клавишу для выхода..."),
        _ = readChar().

end implement main

goal
    console::runUtf8(main::run).
