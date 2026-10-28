implement main
    open core, stdio
class predicates
    capitalize : (string W) -> string R.

clauses
    capitalize("") = "" :-
        !.
    capitalize(W) = string::concat(string::toUpperCase(string::subString(W, 0, 1)), string::toLowerCase(string::subString(W, 1, string::length(W) - 1))).

clauses
    run() :-
        S = "visual PROLOG сочетает логику и объекты",
        Words = [capitalize(W) || W in string::split(S, " ")],
        write(string::concatWithDelimiter(Words, " "), "\n").

end implement main

goal
    console::runUtf8(main::run).
