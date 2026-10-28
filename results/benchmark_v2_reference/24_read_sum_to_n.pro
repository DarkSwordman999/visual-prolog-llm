implement main
    open core, stdio
clauses
    run() :-
        N = toTerm(integer, readLine()),
        write(N * (N + 1) div 2, "\n").

end implement main

goal
    console::runUtf8(main::run).
