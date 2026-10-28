implement main
    open core, stdio
class predicates
    isArmstrong : (integer N) determ.

clauses
    isArmstrong(N) :-
        A = N div 100,
        B = N div 10 mod 10,
        C = N mod 10,
        A * A * A + B * B * B + C * C * C = N.

clauses
    run() :-
        foreach N = std::fromTo(100, 999) and isArmstrong(N) do
            write(N, " ")
        end foreach,
        write("\n").

end implement main

goal
    console::runUtf8(main::run).
