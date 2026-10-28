implement main
    open core, stdio
class predicates
    gray : (integer N) -> string* Codes.

clauses
    gray(0) = [""] :-
        !.
    gray(N) = list::append([string::concat("0", C) || C in Prev], [string::concat("1", C) || C in list::reverse(Prev)]) :-
        Prev = gray(N - 1).

clauses
    run() :-
        foreach N in [1, 2, 3] do
            write(N, " бит: ", gray(N), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
