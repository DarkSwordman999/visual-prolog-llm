implement main
    open core, stdio
class predicates
    digitSum : (char* L) -> integer S.

clauses
    digitSum([]) = 0.
    digitSum([C | T]) = V - 48 + digitSum(T) :-
        V = string::getCharValue(C),
        V >= 48,
        V <= 57,
        !.
    digitSum([_ | T]) = digitSum(T).

clauses
    run() :-
        write(digitSum(string::toCharList("a1b2c3d10")), "\n").

end implement main

goal
    console::runUtf8(main::run).
