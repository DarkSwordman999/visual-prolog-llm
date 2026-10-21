/*******************************
Project Name: primtype2
UI Strategy:  console
********************************/
% File main.pro
implement main
    open core
constants
    className = "main".
    classVersion = "primtype2".
clauses
    classInfo(className, classVersion).
class predicates
    color:(symbol, integer) procedure (i,  o).
clauses

   color("red", 0x00FF0000) :- !.
   color("blue", 0x000000FF) :- !.
   color("green", 0x0000FF00) :- !.
   color(_, 0x0).

   run():- console::init(),
        color("red", C),
        S= string::format("%x\n", C),
        stdio::write(S), stdio::nl,
        succeed().
end implement main

goal
    mainExe::run(main::run).
    