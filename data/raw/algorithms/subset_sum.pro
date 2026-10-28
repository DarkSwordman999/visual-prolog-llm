implement main
    open core, stdio
class predicates
    subsetSum : (integer* L, integer Target) -> integer* Subset nondeterm.

clauses
    subsetSum(_, 0) = [].
    subsetSum([H | T], S) = [H | subsetSum(T, S - H)] :-
        S > 0,
        H <= S.
    subsetSum([_ | T], S) = subsetSum(T, S) :-
        S > 0.

clauses
    run() :-
        L = [3, 34, 4, 12, 5, 2],
        foreach S in [9, 30, 100] do
            if X = subsetSum(L, S) then
                write(S, ": ", X, "\n")
            else
                write(S, ": нет\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
