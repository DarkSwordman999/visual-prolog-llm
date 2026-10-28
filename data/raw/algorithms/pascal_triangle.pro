implement main
    open core, stdio
class predicates
    pascal : (integer N) -> integer* Row.
    nextRow : (integer* Row) -> integer* Next.
    addPairs : (integer* Row) -> integer* Sums.

clauses
    pascal(0) = [1] :-
        !.
    pascal(N) = nextRow(pascal(N - 1)).

    nextRow(Row) = [1 | addPairs(Row)].

    addPairs([A, B | T]) = [A + B | addPairs([B | T])] :-
        !.
    addPairs(_) = [1].

clauses
    run() :-
        foreach I = std::fromTo(0, 6) do
            write(pascal(I), "\n")
        end foreach,
        write("C(6, 2) = ", list::nth(2, pascal(6)), "\n").

end implement main

goal
    console::runUtf8(main::run).
