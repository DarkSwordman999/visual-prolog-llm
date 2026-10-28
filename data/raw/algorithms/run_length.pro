implement main
    open core, stdio
class predicates
    encode : (char* L) -> string S.
    encodeAcc : (char* L, char Cur, integer N) -> string S.

clauses
    encode([]) = "".
    encode([H | T]) = encodeAcc(T, H, 1).

    encodeAcc([], Cur, N) = string::concat(string::charToString(Cur), toString(N)).
    encodeAcc([H | T], Cur, N) = encodeAcc(T, Cur, N + 1) :-
        H = Cur,
        !.
    encodeAcc([H | T], Cur, N) = string::concat(string::charToString(Cur), toString(N), encodeAcc(T, H, 1)).

clauses
    run() :-
        foreach S in ["aaabccdddd", "abc", "zzzzzz"] do
            write(S, " -> ", encode(string::toCharList(S)), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
