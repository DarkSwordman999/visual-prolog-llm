implement main
    open core, stdio
class predicates
    isCapital : (string W) determ.

clauses
    isCapital(W) :-
        W <> "",
        F = string::subString(W, 0, 1),
        F = string::toUpperCase(F),
        F <> string::toLowerCase(F).

clauses
    run() :-
        Words = string::split("Мама мыла Раму и Кота", " "),
        write(list::length([W || W in Words, isCapital(W)]), "\n").

end implement main

goal
    console::runUtf8(main::run).
