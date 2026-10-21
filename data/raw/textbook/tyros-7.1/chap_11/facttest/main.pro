 %File main.pro
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
   addItem:(volume).
   prtDataBase:().

clauses
    classInfo("main", "facttest").

   addItem(V) :- num := num+1,
       assert(item(V, num)).

   prtDataBase() :- item(V, I),
      stdio::write(I, "=", V), stdio::nl,
      fail.
   prtDataBase().

clauses
  run():-
    console::init(),
    addItem(journal("AI in focus", "MIT Press")),
    addItem(book( "Databases in Prolog",
                   n1("Wellesley Barros"))),
    file::save("bibliography.fac",  bib),
    prtDataBase().
end implement main

goal
    mainExe::run(main::run).