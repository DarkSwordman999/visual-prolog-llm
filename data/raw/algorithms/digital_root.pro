implement main
    open core, stdio
class predicates
    digitSum : (integer N) -> integer S.
    root : (integer N) -> integer R.

clauses
    digitSum(0) = 0 :-
        !.
    digitSum(N) = N mod 10 + digitSum(N div 10).

    root(N) = N :-
        N < 10,
        !.
    root(N) = root(digitSum(N)).

clauses
    run() :-
        foreach N in [7, 38, 9875, 123456789] do
            write("Цифровой корень ", N, " = ", root(N), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
