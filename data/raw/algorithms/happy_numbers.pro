implement main
    open core, stdio
class predicates
    sqDigits : (integer N) -> integer S.
    isHappy : (integer N, integer* Seen) determ.

clauses
    sqDigits(0) = 0 :-
        !.
    sqDigits(N) = D * D + sqDigits(N div 10) :-
        D = N mod 10.

    isHappy(1, _) :-
        !.
    isHappy(N, Seen) :-
        not(list::isMember(N, Seen)),
        isHappy(sqDigits(N), [N | Seen]).

clauses
    run() :-
        write("Счастливые числа до 50: ", [N || N = std::fromTo(1, 50), isHappy(N, [])], "\n").

end implement main

goal
    console::runUtf8(main::run).
