% File: draw.pro
implement draw
open core, vpiDomains, vpi, math

clauses
 classInfo("plotter/draw",  "1.0").
domains
 command = t(commandList); f(integer);
    r(integer); m.
 commandList= command*.
class facts
       pos:(real Delta, real Turn) single.
       grammar:(commandList) single.
class predicates
   move:(windowHandle, pnt, real, commandList)
           procedure (i, i, i, i).
   derive:(commandList, commandList)
                  procedure (i, o).
   mv:(windowHandle, pnt, real, command, pnt, real)
                procedure (i,i, i, i, o, o).
   iter:(integer, commandList, commandList) procedure (i, i, o).

clauses
       pos(4.0,  0.1745329).

       grammar([f(1)]).

      iter(0, S, S) :- !.
      iter(I, InTree, OutTree) :- derive(InTree, S),
         iter(I-1, S, OutTree).

      derive([], []) :- !.
      derive([f(0)|Rest], [f(0),f(0)|S]) :- !,
           derive(Rest, S).
      derive([f(_)|Rest],
               [f(0), t([r(1),f(1)]), f(0),
                      t([r(-1),f(1)]), r(1), f(1)|S]) :- !,
            derive(Rest, S).
      derive([t(Branches)|Rest], [t(B)|S]) :- !,
           derive(Branches, B),
           derive(Rest, S).
      derive([X|Rest], [X|S]) :- derive(Rest, S).

       mv(Win, P1, Facing,  f(_), P2, Facing) :- !,
          pos(Displacement,  _Turn),
          P1= pnt(X1, Y1),
          X2=  round( X1+ Displacement*cos(Facing)),
          Y2= round( Y1+Displacement*sin(Facing)),
          P2= pnt(X2, Y2),
          drawline(Win,  P1, P2).
       mv(_Win, P1, Facing, m, P2, Facing) :- !,
          pos(Displacement,  _Turn),
          P1= pnt(X1, Y1),
          X2=  round( X1+ Displacement*cos(Facing)),
          Y2=  round(Y1+Displacement*sin(Facing)),
          P2= pnt(X2, Y2).
       mv(_Win, P1, Facing,  r(Direction), P1, F) :- !,
          pos(_Displacement,  Turn),
          F= Facing+ Direction*Turn.
       mv(Win, P1, Facing, t(B), P1, Facing) :-
            move(Win, P1, Facing,  B).

      move(_Win, _P1, _Facing, []) :- !.
      move(Win, P1, Facing,  [X|Rest]) :-
          mv(Win, P1, Facing,  X, P, F),
          move(Win, P, F,  Rest).

      tree(Win) :- grammar(Commands),
         iter(5, Commands, C),
         Facing= -pi/2,
         Point= pnt(100, 250),
         move(Win, Point, Facing,  C).
end implement draw
