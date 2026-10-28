implement main
    open core, stdio
class predicates
    isPalindrome : (string S) determ.
    clean : (char* L) -> char* R.
    reverse : (char* L, char* Acc) -> char* R.

clauses
    isPalindrome(S) :-
        L = clean(string::toCharList(string::toLowerCase(S))),
        L = reverse(L, []).

    clean([]) = [].
    clean([' ' | T]) = clean(T) :-
        !.
    clean([C | T]) = [C | clean(T)].

    reverse([], Acc) = Acc.
    reverse([H | T], Acc) = reverse(T, [H | Acc]).

clauses
    run() :-
        foreach S in ["Шалаш", "А роза упала на лапу Азора", "Пролог", "level"] do
            write("\"", S, "\"", if isPalindrome(S) then " - палиндром" else " - не палиндром" end if, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
