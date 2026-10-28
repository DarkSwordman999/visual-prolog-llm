implement main
    open core, stdio
class predicates
    gen : (integer Open, integer Close, integer N) -> string S nondeterm.

clauses
    gen(N, N, N) = "".
    gen(Open, Close, N) = string::concat("(", gen(Open + 1, Close, N)) :-
        Open < N.
    gen(Open, Close, N) = string::concat(")", gen(Open, Close + 1, N)) :-
        Close < Open.

clauses
    run() :-
        All = [S || S = gen(0, 0, 3)],
        write("Всего: ", list::length(All), "\n"),
        foreach S in All do
            write(S, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
