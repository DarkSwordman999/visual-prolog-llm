implement main
    open core, stdio
class predicates
    longest : (string* Words, string Best) -> string L.

clauses
    longest([], Best) = Best.
    longest([W | T], Best) = longest(T, W) :-
        string::length(W) > string::length(Best),
        !.
    longest([_ | T], Best) = longest(T, Best).

clauses
    run() :-
        S = "Visual Prolog  сочетает логическое и объектно-ориентированное программирование",
        Words = [W || W in string::split(S, " "), W <> ""],
        write("Слов: ", list::length(Words), "\n"),
        write("Самое длинное: ", longest(Words, ""), "\n").

end implement main

goal
    console::runUtf8(main::run).
