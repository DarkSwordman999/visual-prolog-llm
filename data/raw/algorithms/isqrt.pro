implement main
    open core, stdio
class predicates
    isqrt : (integer64 N) -> integer64 R.
    search : (integer64 Lo, integer64 Hi, integer64 N) -> integer64 R.

clauses
    isqrt(N) = search(0, N, N).

    search(Lo, Hi, _) = Lo :-
        Lo >= Hi,
        !.
    search(Lo, Hi, N) = search(Mid, Hi, N) :-
        Mid = (Lo + Hi + 1) div 2,
        Mid * Mid <= N,
        !.
    search(Lo, Hi, N) = search(Lo, (Lo + Hi + 1) div 2 - 1, N).

clauses
    run() :-
        foreach N in [0, 1, 15, 16, 17, 1000000, 2147395600] do
            write("isqrt(", N, ") = ", isqrt(N), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
