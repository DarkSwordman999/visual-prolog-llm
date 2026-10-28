implement main
    open core, stdio
clauses
    run() :-
        write(list::length(list::removeDuplicates(string::toCharList("abracadabra"))), "\n").

end implement main

goal
    console::runUtf8(main::run).
