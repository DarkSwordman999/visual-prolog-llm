implement main
    open core, stdio
class predicates
    sum : (integer* L) -> integer S.
    minMax : (integer* L, integer Min, integer Max, integer MinOut [out], integer MaxOut [out]).

clauses
    sum([]) = 0.
    sum([H | T]) = H + sum(T).

    minMax([], Min, Max, Min, Max).
    minMax([H | T], Min, Max, MinOut, MaxOut) :-
        minMax(T, math::min(H, Min), math::max(H, Max), MinOut, MaxOut).

clauses
    run() :-
        write("Введите числа через пробел: "),
        Line = readLine(),
        Numbers = [toTerm(integer, P) || P in string::split(Line, " "), P <> ""],
        write("\nЧисла: ", Numbers, "\n"),
        write("Сумма: ", sum(Numbers), "\n"),
        if [First | Rest] = Numbers then
            minMax(Rest, First, First, Min, Max),
            write("Минимум: ", Min, ", максимум: ", Max, "\n")
        end if.

end implement main

goal
    console::runUtf8(main::run).
