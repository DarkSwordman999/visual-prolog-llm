implement dopaint
    open core, vpiDomains

constants
    className = "snake/snakestate".
    classVersion = "".

class facts
    yesno:integer := 0.

class predicates
     flipflop:(picture Picture,
                 picture Mask) determ (o, o).

clauses
    classInfo(className, classVersion).

    flipflop(Pict, Mask) :- yesno= 0,
         yesno := 1,
         Pict= vpi::pictLoad("figs\\n0.bmp"),
         Mask= vpi::pictLoad("figs\\n0Mask.bmp"), !.
     flipflop(Pict, Mask) :- yesno= 1,
         yesno := 0,
         Pict= vpi::pictLoad("figs\\n1.bmp"),
         Mask= vpi::pictLoad("figs\\n1Mask.bmp").

    draw(W) :-
       P= vpi::pictLoad("figs\\frogs.bmp"),
       W:pictDraw(P, pnt(10, 10), rop_SrcCopy),
       flipflop(Snake, Mask), !,
       W:pictDraw(Mask, pnt(40, 50), rop_SrcAnd),
       W:pictDraw(Snake, pnt(40, 50), rop_SrcInvert).
     draw(_).

     invalidRectangle(rct(40, 50, 100, 100)).
     end implement dopaint