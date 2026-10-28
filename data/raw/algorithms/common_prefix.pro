implement main
    open core, stdio
class predicates
    prefix2 : (char* A, char* B) -> char* P.
    prefixAll : (string* L, char* Acc) -> char* P.

clauses
    prefix2([C | A], [C | B]) = [C | prefix2(A, B)] :-
        !.
    prefix2(_, _) = [].

    prefixAll([], Acc) = Acc.
    prefixAll([S | T], Acc) = prefixAll(T, prefix2(Acc, string::toCharList(S))).

clauses
    run() :-
        foreach L in [["программа", "программист", "прогресс"], ["кот", "собака"], ["один"]] do
            if [First | Rest] = L then
                P = prefixAll(Rest, string::toCharList(First)),
                write(L, " -> \"", string::createFromCharList(P), "\"\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
