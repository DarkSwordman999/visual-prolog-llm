implement main
    open core, stdio
class predicates
    twoSum : (integer* L, integer Target, integer A [out], integer B [out]) determ.

clauses
    twoSum([H | T], S, H, B) :-
        B = S - H,
        list::isMember(B, T),
        !.
    twoSum([_ | T], S, A, B) :-
        twoSum(T, S, A, B).

clauses
    run() :-
        L = [2, 7, 11, 15, -3],
        foreach S in [9, 12, 100] do
            if twoSum(L, S, A, B) then
                write(S, " = ", A, " + ", B, "\n")
            else
                write("Для ", S, " пары нет\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
