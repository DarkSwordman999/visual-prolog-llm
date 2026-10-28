implement main
    open core, stdio
class predicates
    digitSum : (integer N) -> integer S.

clauses
    digitSum(N) = N :-
        N < 10,
        !.
    digitSum(N) = N mod 10 + digitSum(N div 10).

clauses
    run() :-
        write("Сумма цифр 12345 = ", digitSum(12345), "\n"),
        write("Сумма цифр 9 = ", digitSum(9), "\n").

end implement main

goal
    console::runUtf8(main::run).
