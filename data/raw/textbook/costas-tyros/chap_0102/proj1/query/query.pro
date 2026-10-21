/*****************************************************************************

                         Utah State University

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

predicates
    onMouseDown : drawWindow::mouseDownListener.
clauses
   onMouseDown(S,  Point, _ShiftControlAlt, _Button) :-
     W= S:getVPIWindow(),
     Point= pnt(X, Y),
     vpi::drawText(W, X, Y, "Hello, World!").

% This code is maintained automatically, do not update it manually. 23:29:12-29.7.2007
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("query"),
        setRect(rct(50,40,158,108)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        addMouseDownListener(onMouseDown),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(4, 46),
        ok_ctl:setSize(30, 12),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(40, 46),
        cancel_ctl:setSize(30, 12),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(76, 46),
        help_ctl:setSize(30, 12),
        help_ctl:setAnchors([control::right,control::bottom]).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement query
