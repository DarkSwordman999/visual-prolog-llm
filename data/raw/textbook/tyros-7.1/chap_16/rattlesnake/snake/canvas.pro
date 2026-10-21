/*****************************************************************************

                         Utah State University

******************************************************************************/

implement canvas
    inherits formWindow
    open core, vpiDomains

constants
    className = "snake/canvas".
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
    onDestroy : window::destroyListener.
clauses
 onDestroy(W) :- click::kill(W).

predicates
    onTimer : window::timerListener.
clauses
 onTimer(_Source, _TimerID) :-
        dopaint::invalidRectangle(R),
        invalidate(R).

predicates
    onPaint : drawWindow::paintResponder.
clauses
   onPaint(_Source, _Rectangle, GDIObject) :-
       dopaint::draw(GDIObject).

% This code is maintained automatically, do not update it manually. 00:35:02-2.8.2007
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("canvas"),
        setRect(rct(50,40,290,160)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        addDestroyListener(onDestroy),
        addTimerListener(onTimer),
        setPaintResponder(onPaint),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(72, 102),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(128, 102),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(184, 102),
        help_ctl:setAnchors([control::right,control::bottom]).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement canvas
