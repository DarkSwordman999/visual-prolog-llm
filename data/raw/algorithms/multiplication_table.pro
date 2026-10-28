implement main
    open core, stdio
clauses
    run() :-
        write("Введите число: "),
        N = toTerm(integer, readLine()),
        write("\n"),
        foreach I = std::fromTo(1, 10) do
            writef("% x % = %\n", N, I, N * I)
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
