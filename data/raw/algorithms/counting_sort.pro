implement main
    open core, stdio
class predicates
    countOf : (integer V, integer* L) -> integer N.
    repeat : (integer V, integer N) -> integer* R.

clauses
    countOf(V, L) = list::length([X || X in L, X = V]).

    repeat(_, 0) = [] :-
        !.
    repeat(V, N) = [V | repeat(V, N - 1)].

clauses
    run() :-
        Marks = [5, 3, 4, 5, 2, 3, 5, 4, 1, 3],
        Sorted = list::appendList([repeat(V, countOf(V, Marks)) || V = std::fromTo(1, 5)]),
        foreach V = std::fromTo(1, 5) do
            write("Оценка ", V, ": ", countOf(V, Marks), "\n")
        end foreach,
        write("По возрастанию: ", Sorted, "\n").

end implement main

goal
    console::runUtf8(main::run).
