/*****************************************************************************

                        Copyright © 

******************************************************************************/

implement query
    inherits formWindow
    open core, vpiDomains

constants
    className = "query/query".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

class facts
   mousePoint:pnt := pnt(-1, -1).

predicates
    onMouseDown : drawWindow::mouseDownListener.

clauses
   onMouseDown(_S,  Point, _ShiftControlAlt, _Button) :-
        mousePoint := Point,
        Point= pnt(X, Y),
        R= rct(X-8, Y-8, X+60, Y+8),
        invalidate(R).

predicates
    onPaint : drawWindow::paintResponder.

clauses
    onPaint(_Source, _Rectangle, GDIObject) :-
      if     pnt(X, Y)= mousePoint,  X>0
      then
         mousePoint := pnt(-1, -1),
         GDIObject:drawText(pnt(X, Y), "Hello, World!", -1)
      else succeed() end if.

% This code is maintained automatically, do not update it manually. 12:55:40-31.8.2010
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("query"),
        setRect(rct(50,40,290,160)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addMouseDownListener(onMouseDown),
        setPaintResponder(onPaint),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(48, 98),
        ok_ctl:setSize(56, 16),
        ok_ctl:defaultHeight := false(),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(112, 98),
        cancel_ctl:setSize(56, 16),
        cancel_ctl:defaultHeight := false(),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(176, 98),
        help_ctl:setSize(56, 16),
        help_ctl:defaultHeight := false(),
        help_ctl:setAnchors([control::right,control::bottom]),
        setDefaultButton(ok_ctl).
% end of automatic code
end implement query
