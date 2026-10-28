implement main
    open core, stdio
class predicates
    subset : (integer* L) -> integer* S nondeterm.

clauses
    subset([]) = [].
    subset([H | T]) = [H | subset(T)].
    subset([_ | T]) = subset(T).

clauses
    run() :-
        All = [S || S = subset([1, 2, 3])],
        write("Всего подмножеств: ", list::length(All), "\n"),
        foreach S in All do
            write(S, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
