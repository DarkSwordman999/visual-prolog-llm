implement main
    open core, stdio
class predicates
    solve : (real A, real B, real C).

clauses
    solve(0, 0, _) :-
        !,
        write("Не уравнение второй степени и без x\n").
    solve(0, B, C) :-
        !,
        write("Линейное уравнение, x = ", -C / B, "\n").
    solve(A, B, C) :-
        D = B * B - 4 * A * C,
        if D > 0 then
            write("x1 = ", (-B + math::sqrt(D)) / (2 * A), ", x2 = ", (-B - math::sqrt(D)) / (2 * A), "\n")
        elseif D = 0 then
            write("x = ", -B / (2 * A), "\n")
        else
            write("Вещественных корней нет\n")
        end if.

clauses
    run() :-
        solve(1, -3, 2),
        solve(1, 2, 1),
        solve(1, 0, 1),
        solve(0, 2, -4).

end implement main

goal
    console::runUtf8(main::run).
