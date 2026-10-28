implement main
    open core, stdio
class predicates
    search : (integer X, integer* L, integer Lo, integer Hi) -> integer Index determ.

clauses
    search(X, L, Lo, Hi) = I :-
        Lo <= Hi,
        Mid = (Lo + Hi) div 2,
        V = list::nth(Mid, L),
        if V = X then
            I = Mid
        elseif V < X then
            I = search(X, L, Mid + 1, Hi)
        else
            I = search(X, L, Lo, Mid - 1)
        end if.

clauses
    run() :-
        L = [1, 3, 5, 7, 9, 11, 13, 15],
        Hi = list::length(L) - 1,
        foreach X in [7, 1, 15, 4] do
            if I = search(X, L, 0, Hi) then
                write(X, " найден на позиции ", I, "\n")
            else
                write(X, " не найден\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
