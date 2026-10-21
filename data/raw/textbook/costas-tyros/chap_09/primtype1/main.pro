/********************************
Project Name: primtype1
UI Strategy:  console
*********************************/   
% File main.pro
implement main
    open core
constants
    className = "main".
    classVersion = "primtype1".
clauses
    classInfo(className, classVersion).
class predicates
    energy:(real, real, real) procedure (i, i, o).
    family:(symbol, string) procedure (i, o).
clauses
   energy(N, Z, E) :- E= -2.18E-19*Z*Z/(N*N).

   family("Na", "alkaline metal") :- !.
   family(_, "unknown").

   run():- console::init(),
        energy(4, 1, E1),
        energy(2, 1, E2),
        DeltaE= E1-E2,
        stdio::write(DeltaE), stdio::nl,
        family("Na", F),
        stdio::write("Na", " is an ", F), stdio::nl,
        succeed().
end implement main

goal
    mainExe::run(main::run).
    