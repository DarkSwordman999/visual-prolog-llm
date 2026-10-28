implement main
    open core, stdio
class predicates
    maxAcc : (integer* L, integer Best) -> integer M.
    minAcc : (integer* L, integer Best) -> integer M.

clauses
    maxAcc([], Best) = Best.
    maxAcc([H | T], Best) = maxAcc(T, H) :-
        H > Best,
        !.
    maxAcc([_ | T], Best) = maxAcc(T, Best).

    minAcc([], Best) = Best.
    minAcc([H | T], Best) = minAcc(T, H) :-
        H < Best,
        !.
    minAcc([_ | T], Best) = minAcc(T, Best).

clauses
    run() :-
        L = [7, -2, 15, 3, 15, 0],
        if [H | T] = L then
            write("Максимум: ", maxAcc(T, H), "\n"),
            write("Минимум: ", minAcc(T, H), "\n")
        end if.

end implement main

goal
    console::runUtf8(main::run).
