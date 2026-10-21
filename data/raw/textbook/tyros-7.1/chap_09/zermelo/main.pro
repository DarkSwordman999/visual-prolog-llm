implement main
    open core

clauses
    classInfo("main", "zermelo").

    run():-
        console::init(),
        Q= [tuple(X, Y) || X= std::fromTo(1, 4),
                           Y= std::fromTo(1, 5)],
        stdio::nl,
        stdio::write(Q), stdio::nl, stdio::nl,
        foreach tuple(Num, Den)= list::getMember_nd(Q) do
          stdio::write(Num, "/", Den,", ")
        end foreach,
        stdio::nl.
end implement main

goal
    mainExe::run(main::run).
    