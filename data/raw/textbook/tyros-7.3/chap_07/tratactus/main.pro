/***********************************

Project Name: tratactus
UI Strategy:  console

************************************/

implement main
   open core, console, semantic
class predicates
    test:().
clauses
 classInfo("main", "tratactus").

 test() :- german::phr(T, ["die", "Welt", "ist", "alles"], _X),
     write(T), nl, english::phr(T, Translation), !,
     write(Translation), nl.
 test().

 run():- console::init(), test().
end implement main
goal mainExe::run(main::run).