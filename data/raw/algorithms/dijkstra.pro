implement main
    open core, stdio
domains
    cand = d(integer Dist, string Node).

class facts
    road : (string A, string B, integer Weight).

class predicates
    adjacent : (string A, string B [out], integer W [out]) nondeterm.
    dijkstra : (cand* Queue, string* Done, string Goal) -> integer Dist determ.

clauses
    road("Москва", "Тула", 180).
    road("Москва", "Калуга", 190).
    road("Тула", "Орёл", 190).
    road("Калуга", "Орёл", 210).
    road("Тула", "Рязань", 230).
    road("Москва", "Рязань", 200).
    road("Рязань", "Тамбов", 290).
    road("Орёл", "Курск", 160).

    adjacent(A, B, W) :-
        road(A, B, W).
    adjacent(A, B, W) :-
        road(B, A, W).

    dijkstra([d(D, Goal) | _], _, Goal) = D :-
        !.
    dijkstra([d(_, N) | Rest], Done, Goal) = dijkstra(Rest, Done, Goal) :-
        list::isMember(N, Done),
        !.
    dijkstra([d(D, N) | Rest], Done, Goal) = dijkstra(list::sort(list::append(Rest, New)), [N | Done], Goal) :-
        New = [d(D + W, M) || adjacent(N, M, W), not(list::isMember(M, Done))].

clauses
    run() :-
        foreach Goal in ["Орёл", "Курск", "Тамбов", "Москва"] do
            if D = dijkstra([d(0, "Москва")], [], Goal) then
                write("Москва -> ", Goal, ": ", D, " км\n")
            end if
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
