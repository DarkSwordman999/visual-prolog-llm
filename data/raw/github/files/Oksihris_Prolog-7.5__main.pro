

implement main
    open core, console

class facts
    streets : (string District, string NameStreet).

clauses
    streets("Шевченківський", "Сумська") .
    streets("Немишлянський", "Садова") .
    streets("Індустріальний", "Харківське шосе") .
    streets("Київський", "Пушкінська").
    streets("Київський", "Бікетова").
    streets("Немишлянський", "Садова").
    streets("Індустріальний", "Харківське шосе").
    streets("Київський", "Мироносицька").
    run() :-

    write("Введіть назву першої вулиці:  "),nl,
    Street1 = readLine(),nl,

    write("Введіть назву другої вулиці:  "),nl,
    Street2 = readLine(),nl,

    streets(District1, Street1),
    streets(District2, Street2),
    District1 = District2, !,
    write("Вулиці знаходяться в одному районі"),
    _ = readChar()
    ; %Дизъюнкция позволяет обратить цель в тождественно истинную
    write("Вулиці знаходяться в різних районах"),
    _ = readChar(). %Ожидает нажатие клавиши





end implement main

goal
    console::run(main::run).