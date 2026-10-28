implement main
    open core, stdio
class predicates
    power : (integer Base, integer Exp) -> integer Result.

clauses
    power(_, 0) = 1 :-
        !.
    power(B, E) = H * H :-
        E mod 2 = 0,
        !,
        H = power(B, E div 2).
    power(B, E) = B * power(B, E - 1).

clauses
    run() :-
        write("2^10 = ", power(2, 10), "\n"),
        write("3^13 = ", power(3, 13), "\n"),
        write("5^0 = ", power(5, 0), "\n").

end implement main

goal
    console::runUtf8(main::run).
