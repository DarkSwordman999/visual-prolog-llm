implement main

class predicates
   fact:(integer N, integer Res)  procedure (i,o).
clauses
   classinfo("facfun", "1.0").

   fact(N, 1) :- N<1, !.
   fact(N, N*F) :- fact(N-1, F).

   run():- console::init(),
        fact(stdio::read(), F), stdio::write(F), stdio::nl.
end implement main

goal
    mainExe::run(main::run).
    