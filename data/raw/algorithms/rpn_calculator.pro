implement main
    open core, stdio
class predicates
    eval : (string* Tokens, integer* Stack) -> integer R determ.
    apply : (string Op, integer A, integer B) -> integer R determ.

clauses
    eval([], [R]) = R.
    eval([T | Ts], [B, A | S]) = eval(Ts, [apply(T, A, B) | S]) :-
        list::isMember(T, ["+", "-", "*", "/"]),
        !.
    eval([T | Ts], S) = eval(Ts, [N | S]) :-
        N = tryToTerm(integer, T).

    apply("+", A, B) = A + B.
    apply("-", A, B) = A - B.
    apply("*", A, B) = A * B.
    apply("/", A, B) = A div B :-
        B <> 0.

clauses
    run() :-
        foreach E in ["3 4 + 2 *", "5 1 2 + 4 * + 3 -", "2 3 4 * +", "1 +"] do
            if R = eval(string::split(E, " "), []) then
                write(E, " = ", R, "\n")
            else
                write(E, " - ошибка в выражении\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
