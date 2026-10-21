%File draw.pro
implement draw
   open core, vpiDomains, vpi
   class predicates
       draw:(windowHandle, objstate) procedure.

   clauses
       classInfo("playground/draw",  "1.0").

       draw(W, S) :-
          S:segm(Rectangle),
          vpi::drawEllipse(W, Rectangle),
          fail.
       draw(_W, _S).

       snapshot(Win, S) :-
           S:mov(), !,
           Rectangle= rct(0, 0, 200, 200),
           W= pictOpen(Rectangle),
           draw(W, S),
           Pict= pictClose(W),
           Win:pictDraw(Pict, pnt(10, 10),  rop_SrcCopy).
end implement draw
