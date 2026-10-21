% File: main.pro
implement main
    open core
domains
   name= string.
   author= n1(name);  n2(name, name); etal(name).
   publisher= string.
   title= string.
   volume= journal(title, publisher); book(title, author).

class facts - bib
  num:integer := 0.
  item:(volume, integer) nondeterm.

class predicates
   prtDataBase:().

clauses
   classInfo("main", "factread").

   prtDataBase() :- item(V, I),
      stdio::write(I, "=", V), stdio::nl,
      fail.
   prtDataBase().

clauses
    run():-
        console::init(),
        file::consult("bibliography.fac",  bib),
        prtDataBase().
end implement main

goal
    mainExe::run(main::run).