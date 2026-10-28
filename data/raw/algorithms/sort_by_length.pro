implement main
    open core, stdio
clauses
    run() :-
        Words = ["пролог", "и", "логика", "код", "вывод", "правило", "факт"],
        Pairs = list::sort([tuple(string::length(W), W) || W in Words]),
        write([W || tuple(_, W) in Pairs], "\n").

end implement main

goal
    console::runUtf8(main::run).
