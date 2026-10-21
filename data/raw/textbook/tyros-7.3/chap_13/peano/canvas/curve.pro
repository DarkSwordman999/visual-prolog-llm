%File: curve.pro
/******************************************
implement curve
    open core, vpi, vpiDomains, math

    class predicates
       star:(windowHandle, integer, real, integer) procedure (i, i, i, i).
    clauses
        classInfo("plotter/curve", "1.0").

       star(_Win, 0,  _A, _L) :- !.
       star(Win, N, A, L) :- turtle::right(A),
          turtle::forward(Win, L),
          star(Win, N-1, A, L).

        drawCurve(Win) :-  star(Win, 10, 3*pi/5, 40).
end implement curve
**********************************************************/
implement curve
    open core, vpi, vpiDomains, math
    class predicates
       peano:(windowHandle, integer, real, integer) procedure (i, i, i, i).

    clauses
        classInfo("plotter/curve", "1.0").

       peano(_Win, N, _A, _H) :- N<1, !.
       peano(Win, N, A, H) :- turtle::right(A),
           peano(Win, N-1, -A, H),
           turtle::forward(Win, H),
           peano(Win, N-1, A, H),
           turtle::forward(Win, H),
           peano(Win, N-1, -A, H),
           turtle::left(A).

        drawCurve(Win) :- turtle::move(-60), peano(Win, 6, pi/2, 5).
end implement curve
