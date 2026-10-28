implement main
    open core, stdio
clauses
    run() :-
        write([I || I = std::fromTo(1, 10), I mod 3 <> 0], "\n").

end implement main

goal
    console::runUtf8(main::run).
