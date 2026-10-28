implement main
    open core, stdio
class predicates
    factorial : (integer N) -> integer64 F.
    factAcc : (integer N, integer64 Acc) -> integer64 F.

clauses
    factorial(N) = factAcc(N, 1).

    factAcc(0, Acc) = Acc :-
        !.
    factAcc(N, Acc) = factAcc(N - 1, Acc * N).

clauses
    run() :-
        foreach N in [0, 5, 10, 20] do
            write(N, "! = ", factorial(N), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
