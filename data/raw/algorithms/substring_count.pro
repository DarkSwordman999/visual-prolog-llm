implement main
    open core, stdio
class predicates
    count : (string S, string Sub) -> integer N.

clauses
    count(S, Sub) = 1 + count(string::subString(S, P + 1, string::length(S) - P - 1), Sub) :-
        P = string::search(S, Sub),
        !.
    count(_, _) = 0.

clauses
    run() :-
        foreach tuple(S, Sub) in [tuple("банан", "ан"), tuple("aaaa", "aa"), tuple("пролог", "ог"), tuple("abc", "d")] do
            write("\"", Sub, "\" в \"", S, "\": ", count(S, Sub), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
