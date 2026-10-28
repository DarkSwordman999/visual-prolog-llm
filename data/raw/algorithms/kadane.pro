implement main
    open core, stdio
class predicates
    kadane : (integer* L, integer Cur, integer Best) -> integer B.

clauses
    kadane([], _, Best) = Best.
    kadane([X | T], Cur, Best) = kadane(T, NewCur, math::max(Best, NewCur)) :-
        NewCur = math::max(X, Cur + X).

clauses
    run() :-
        L = [-2, 1, -3, 4, -1, 2, 1, -5, 4],
        if [H | T] = L then
            write("Максимальная сумма: ", kadane(T, H, H), "\n")
        end if.

end implement main

goal
    console::runUtf8(main::run).
