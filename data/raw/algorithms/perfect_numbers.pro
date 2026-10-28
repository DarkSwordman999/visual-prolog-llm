implement main
    open core, stdio
class predicates
    divisorSum : (integer N) -> integer S.

clauses
    divisorSum(N) = list::sum([D || D = std::fromTo(1, N div 2), N mod D = 0]).

clauses
    run() :-
        Perfect = [N || N = std::fromTo(2, 1000), divisorSum(N) = N],
        write("Совершенные числа до 1000: ", Perfect, "\n").

end implement main

goal
    console::runUtf8(main::run).
