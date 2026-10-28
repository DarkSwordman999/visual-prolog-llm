implement main
    open core, stdio
class predicates
    fib : (integer N) -> integer F.
    fibAcc : (integer N, integer A, integer B) -> integer F.

clauses
    fib(N) = fibAcc(N, 0, 1).

    fibAcc(0, A, _) = A :-
        !.
    fibAcc(N, A, B) = fibAcc(N - 1, B, A + B).

clauses
    run() :-
        foreach I = std::fromTo(0, 15) do
            write(fib(I), " ")
        end foreach,
        write("\nfib(40) = ", fib(40), "\n").

end implement main

goal
    console::runUtf8(main::run).
