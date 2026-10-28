implement main
    open core, stdio
class predicates
    countVowels : (char* L) -> integer N.

clauses
    countVowels([]) = 0.
    countVowels([C | T]) = 1 + countVowels(T) :-
        list::isMember(C, string::toCharList("аеёиоуыэюяaeiou")),
        !.
    countVowels([_ | T]) = countVowels(T).

clauses
    run() :-
        foreach S in ["Visual Prolog", "Искусственный интеллект"] do
            write(S, ": гласных ", countVowels(string::toCharList(string::toLowerCase(S))), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
