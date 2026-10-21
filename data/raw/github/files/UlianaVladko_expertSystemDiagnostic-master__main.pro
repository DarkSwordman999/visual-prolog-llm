% Copyright

implement main
    open core, console, string, list, file, std, math, expSubsystem

constants
    fileName = "forms.txt".

class facts - db
    categ : (integer Категория, string Наименование).
    cond : (integer Условие, integer Категория, string Параметр).
    form : (integer Форма, string Название, integer* Симптомы).

class predicates
    intro : ().
    maindialog : ().
    act : (string НомерДействия) determ.
    printForms : ().
    printFormsMini : ().
    printCategorys : ().
    addForm : (string Название).
    deleteForm : (string Форма).
    toList : () -> myTerm*.

clauses
    intro() :-
        write("Экспертная система диагностики форм инфаркта миокарда\n", "Система поможет определить форму инфаркта на основе симптомов.\n").

    maindialog() :-
        repeat(),
        write("\nВыберите один из пунктов меню:\n", "\t1. Диагностика формы инфаркта\n", "\t2. Просмотр базы знаний\n",
            "\t3. Редактирование базы знаний\n", "\t4. Служебные функции\n", "\t5. Выход\n\n", "Пункт: "),
        X = readLine(),
        act(X),
        !.
    maindialog().

    toList() =
        [ Z ||
            categ(A, B),
            Z = categG(A, B)
            or
            cond(C, D, E),
            Z = condG(C, D, E)
            or
            form(F, G, H),
            Z = tourG(F, G, H)
        ].

    act("1") :-
        !,
        write("\nДиагностика формы инфаркта. Выберите действие:\n", "\t1.1 В виде вопросов\n", "\t1.2 В виде меню\n\n", "Пункт: "),
        X = readLine(),
        act(X).

    act("1.1") :-
        !,
        write("Диагностика по симптомам (вопрос-ответ):\n"),
        Q = expSubQuestion::new(toList()),
        Q:expert(),
        fail.

    act("1.2") :-
        !,
        write("Диагностика по меню (выбор симптомов через пробел):\n"),
        M = expSubMenu::new(toList()),
        M:expert(),
        fail.

    act("2") :-
        !,
        write("\nПросмотр базы знаний. Выберите действие:\n", "\t2.1 Просмотр форм инфаркта\n", "\t2.2 Просмотр категорий симптомов\n\n", "Пункт: "),
        X = readLine(),
        act(X).

    act("2.1") :-
        !,
        write("Все формы инфаркта в экспертной системе:\n"),
        printForms(),
        fail.

    act("2.2") :-
        !,
        write("Все категории симптомов:\n"),
        printCategorys(),
        fail.

    act("3") :-
        !,
        write("\nРедактирование базы знаний. Выберите действие:\n", "\t3.1 Добавление формы инфаркта\n", "\t3.2 Удаление формы инфаркта\n\n",
            "Пункт: "),
        X = readLine(),
        act(X).

    act("3.1") :-
        !,
        write("Добавление формы инфаркта. Введите название формы.\n"),
        write("Название формы: "),
        addForm(readLine()),
        fail.

    act("3.2") :-
        !,
        write("Удаление формы инфаркта. Выберите форму для удаления:\n"),
        printFormsMini(),
        write("Удаляемая форма: "),
        deleteForm(readLine()),
        fail.

    act("4") :-
        !,
        write("\nСлужебные функции. Выберите действие:\n", "\t4.1 Сохранить базу (автоматически сохраняется)\n", "\t4.2 Отменить изменения\n\n",
            "Пункт: "),
        X = readLine(),
        act(X).

    act("4.1") :-
        !,
        save(fileName, db),
        write("БД сохранена\n"),
        fail.

    act("4.2") :-
        !,
        retractFactDb(db),
        consult(fileName, db),
        write("Изменения отменены\n"),
        fail.

    act("5") :-
        !,
        write("Выход.\n").

    act(_) :-
        write("Неккоректный ввод, повторите: "),
        X = readLine(),
        act(X).

    printForms() :-
        form(_, N, P),
        writef("%\n", N),
        F =
            { (I) :-
                cond(I, X, Y),
                categ(X, Z),
                !,
                writef("\t% - %\n", Z, Y)
                or
                succeed
            },
        forAll(P, F),
        fail
        or
        succeed.

    printFormsMini() :-
        form(I, N, _),
        writef("\t% - %\n", I, N),
        fail
        or
        succeed.

    printCategorys() :-
        categ(I, X),
        writef("%\n", X),
        cond(N, I, Y),
        writef("\t% - %\n", N, Y),
        fail
        or
        succeed.

    deleteForm(X) :-
        I = tryToTerm(integer, X),
        retract(form(I, N, _)),
        !,
        writef("Форма '% - %' удалена\n", I, N)
        or
        writef("Формы с № % нет в базе данных\n", X).

    addForm(N) :-
        trim(N) = "",
        !,
        writef("Форма '%' должна содержать минимум один значащий символ\n", N)
        or
        form(_, N, _),
        !,
        writef("Форма с именем '%' уже есть в базе данных\n", N)
        or
        I = maximum([ A || form(A, _, _) ]) + 1,
        write("Список всех категорий симптомов:\n"),
        printCategorys(),
        write("Выберите симптом/симптомы: "),
        G = split_delimiter(readLine(), " "),
        S = removeDuplicatesEq({ (A, B) :- A = B }, G),
        R =
            filteredMap(S,
                { (C) = D :-
                    D = tryToTerm(integer, C),
                    cond(D, _, _),
                    !
                }),
        R <> [],
        assert(form(I, N, R)),
        !,
        writef("Форма '% - %' с симптомами: % добавлена\n", I, N, R)
        or
        writef("Форма '%' должна содержать минимум один симптом\n", N).

    run() :-
        setConsoleTitle("Экспертная система диагностики форм инфаркта миокарда"),
        consult(fileName, db),
        intro(),
        maindialog(),
        save(fileName, db),
        _ = readLine().

end implement main

goal
    console::run(main::run).
