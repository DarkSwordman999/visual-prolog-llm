% File: main.pro
implement main
    open core, stdio

clauses
    classInfo("main", "nimgame-1.0").

    run():- console::init(), L= [[1, 1, 1], [1, 1]],
         write(L), nl, nim::game(L), ! ; succeed().
end implement main

goal mainExe::run(main::run).
