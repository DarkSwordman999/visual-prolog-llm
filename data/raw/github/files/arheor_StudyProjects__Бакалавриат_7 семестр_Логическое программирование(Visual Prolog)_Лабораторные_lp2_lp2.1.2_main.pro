% Copyright

implement main
    open core, console

class facts
    автомобиль : (string).

clauses
    автомобиль("КАМАЗ").
    автомобиль("Toyota").
    автомобиль("BMW").

    run() :-
        автомобиль(Авто),
        автомобиль(Авто2),
        Авто <> Авто2,
        write(Авто, " - ", Авто2),
        nl,
        fail
        or
        write("Конец перебора"),
        _ = readchar().

end implement main

goal
    console::runUtf8(main::run).
