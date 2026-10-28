implement main
    open core, stdio
clauses
    run() :-
        write(list::sum([I || I = std::fromTo(1, 100), I mod 2 = 0]), "\n").

end implement main

goal
    console::runUtf8(main::run).
