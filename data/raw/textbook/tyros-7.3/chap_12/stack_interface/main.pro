implement main
    open core

constants
    className = "main".
    classVersion = "".

class predicates
    str_stack:(stack{string}).

clauses
    classInfo(className, classVersion).

   str_stack(S) :-
      S:push("Hello"),
      S:push("World"),
      stdio::write(S:pop(), "!"), !.
   str_stack(_S).  
             
    run():-
        console::init(),
        Q = stackClass::new(), Q:push(17),  
        Q:push(8),
        X= Q:pop(), !,
        stdio::write(X), stdio::nl,
        SS = stackClass{string}::new(), 
        str_stack(SS),
        succeed(). 
     run().
end implement main

goal
    mainExe::run(main::run).
