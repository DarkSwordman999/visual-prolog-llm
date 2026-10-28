implement main
    open core, stdio
class predicates
    josephus : (integer* Circle, integer K, integer* Out) -> integer Last.
    move : (integer* L, integer N) -> integer* R.

clauses
    josephus([X], _, Out) = X :-
        !,
        write("Выбывают: ", list::reverse(Out), "\n").
    josephus(Circle, K, Out) = josephus(Rest, K, [Victim | Out]) :-
        [Victim | Rest] = move(Circle, K - 1),
        !.
    josephus(_, _, _) = 0.

    move(L, 0) = L :-
        !.
    move([H | T], N) = move(list::append(T, [H]), N - 1) :-
        !.
    move(L, _) = L.

clauses
    run() :-
        write("Остаётся: ", josephus([I || I = std::fromTo(1, 7)], 3, []), "\n").

end implement main

goal
    console::runUtf8(main::run).
