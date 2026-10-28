implement main
    open core, stdio
class predicates
    isPrime : (integer N) determ.
    noDivisor : (integer N, integer D) determ.

clauses
    isPrime(N) :-
        N >= 2,
        noDivisor(N, 2).

    noDivisor(N, D) :-
        D * D > N,
        !.
    noDivisor(N, D) :-
        N mod D <> 0,
        noDivisor(N, D + 1).

clauses
    run() :-
        foreach N in [1, 2, 9, 17, 21, 97] do
            if isPrime(N) then
                write(N, " - простое\n")
            else
                write(N, " - не простое\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
