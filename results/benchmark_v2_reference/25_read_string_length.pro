implement main
    open core, stdio
clauses
    run() :-
        write(string::length(readLine()), "\n").

end implement main

goal
    console::runUtf8(main::run).
