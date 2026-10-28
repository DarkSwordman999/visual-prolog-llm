implement main
    open core, stdio
clauses
    run() :-
        write(list::length([D || D = std::fromTo(1, 360), 360 mod D = 0]), "\n").

end implement main

goal
    console::runUtf8(main::run).
