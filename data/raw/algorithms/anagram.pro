implement main
    open core, stdio
class predicates
    isAnagram : (string A, string B) determ.
    letters : (string S) -> char* L.

clauses
    isAnagram(A, B) :-
        letters(A) = letters(B).

    letters(S) = list::sort(string::toCharList(string::toLowerCase(S))).

clauses
    run() :-
        foreach tuple(A, B) in [tuple("листок", "столик"), tuple("Апельсин", "спаниель"), tuple("кот", "ток"), tuple("код", "кот")] do
            write(A, " / ", B, if isAnagram(A, B) then " - анаграммы" else " - не анаграммы" end if, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
