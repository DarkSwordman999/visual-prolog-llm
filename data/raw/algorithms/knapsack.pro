implement main
    open core, stdio
domains
    item = item(string Name, integer Weight, integer Value).

class predicates
    best : (item* Items, integer Capacity, string* Taken [out]) -> integer Value.

clauses
    best([], _, []) = 0.
    best([item(Name, W, V) | T], Cap, Taken) = Result :-
        Skip = best(T, Cap, SkipTaken),
        if W <= Cap then
            Take = V + best(T, Cap - W, TakeTaken),
            if Take > Skip then
                Result = Take,
                Taken = [Name | TakeTaken]
            else
                Result = Skip,
                Taken = SkipTaken
            end if
        else
            Result = Skip,
            Taken = SkipTaken
        end if.

clauses
    run() :-
        Items = [item("ноутбук", 3, 2000), item("гитара", 1, 1500), item("магнитофон", 4, 3000), item("книга", 1, 300)],
        V = best(Items, 4, Taken),
        write("Наибольшая ценность: ", V, "\n"),
        write("Взять: ", Taken, "\n").

end implement main

goal
    console::runUtf8(main::run).
