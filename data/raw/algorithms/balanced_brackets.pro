implement main
    open core, stdio
class predicates
    balanced : (char* L, char* Stack) determ.
    pair : (char Open, char Close) determ.
    isOpen : (char C) determ.
    isClose : (char C) determ.

clauses
    balanced([], []).
    balanced([C | T], S) :-
        isOpen(C),
        !,
        balanced(T, [C | S]).
    balanced([C | T], [O | S]) :-
        pair(O, C),
        !,
        balanced(T, S).
    balanced([C | T], S) :-
        not(isClose(C)),
        balanced(T, S).

    pair('(', ')').
    pair('[', ']').
    pair('{', '}').

    isOpen(C) :-
        list::isMember(C, ['(', '[', '{']).

    isClose(C) :-
        list::isMember(C, [')', ']', '}']).

clauses
    run() :-
        foreach S in ["(a[b]{c})", "([)]", "((()", "f(x) = {[1, 2]}"] do
            write(S, if balanced(string::toCharList(S), []) then " - верно" else " - ошибка" end if, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
