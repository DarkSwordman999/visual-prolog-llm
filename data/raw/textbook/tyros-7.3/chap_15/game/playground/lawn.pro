/*****************************************************************************

                         Utah State University

******************************************************************************/

implement lawn
    inherits formWindow
    open core, vpiDomains

constants
    className = "playground/lawn".
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
    onDestroy(_Source) :- click::kill().

predicates
    onShow : window::showListener.
class facts
    stt:objstate := objstate::new().
clauses
   onShow(Parent, _CreationData) :- stt := objstate::new(),
                            stt:init(), click::bip(Parent).

predicates
    onUpClick : button::clickResponder.
clauses
    onUpClick(_S) = button::defaultAction() :-
        stt:turn(0, -10).
predicates
    onDownClick : button::clickResponder.
 clauses
      onDownClick(_S) = button::defaultAction() :-
            stt:turn(0, 10).

predicates
    onLeftClick : button::clickResponder.
 clauses
      onLeftClick(_S) = button::defaultAction() :-
          stt:turn(-10, 0).

predicates
    onRightClick : button::clickResponder.
clauses
    onRightClick(_S) = button::defaultAction() :-
                    stt:turn(10, 0).

predicates
    onTimer : window::timerListener.
 clauses
   onTimer(_Source, _TimerID) :- stt:mov(),
      R= rct(10, 10, 210, 210),
      invalidate(R).

predicates
    onPaint : drawWindow::paintResponder.
clauses
    onPaint(_Source, _Rectangle, GDIObject) :-
        draw::snapshot(GDIObject, stt).

% This code is maintained automatically, do not update it manually. 19:51:58-31.8.2010
facts
    up_ctl : button.
    down_ctl : button.
    left_ctl : button.
    right_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("lawn"),
        setRect(rct(50,40,318,184)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addDestroyListener(onDestroy),
        addShowListener(onShow),
        addTimerListener(onTimer),
        setPaintResponder(onPaint),
        up_ctl := button::new(This),
        up_ctl:setText("up"),
        up_ctl:setPosition(172, 66),
        up_ctl:setSize(48, 12),
        up_ctl:defaultHeight := false(),
        up_ctl:setClickResponder(onUpClick),
        down_ctl := button::new(This),
        down_ctl:setText("down"),
        down_ctl:setPosition(172, 102),
        down_ctl:setSize(48, 12),
        down_ctl:defaultHeight := false(),
        down_ctl:setClickResponder(onDownClick),
        left_ctl := button::new(This),
        left_ctl:setText("left"),
        left_ctl:setPosition(144, 84),
        left_ctl:setSize(48, 12),
        left_ctl:defaultHeight := false(),
        left_ctl:setClickResponder(onLeftClick),
        right_ctl := button::new(This),
        right_ctl:setText("right"),
        right_ctl:setPosition(196, 84),
        right_ctl:setSize(48, 12),
        right_ctl:defaultHeight := false(),
        right_ctl:setClickResponder(onRightClick).
% end of automatic code
end implement lawn
