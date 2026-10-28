implement main
    open core, stdio
clauses
    run() :-
        B = [4, 5, 6, 7],
        write([X || X in [1, 2, 3, 4, 5], list::isMember(X, B)], "\n").

end implement main

goal
    console::runUtf8(main::run).
