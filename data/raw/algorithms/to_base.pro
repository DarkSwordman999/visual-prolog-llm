implement main
    open core, stdio
class predicates
    toBase : (integer N, integer Base) -> string S.
    toDigits : (integer N, integer Base) -> string S.

clauses
    toBase(0, _) = "0" :-
        !.
    toBase(N, Base) = toDigits(N, Base).

    toDigits(0, _) = "" :-
        !.
    toDigits(N, Base) = string::concat(toDigits(N div Base, Base), string::subString("0123456789ABCDEF", N mod Base, 1)).

clauses
    run() :-
        foreach N in [0, 5, 10, 255, 2026] do
            write(N, ": двоичная ", toBase(N, 2), ", шестнадцатеричная ", toBase(N, 16), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
