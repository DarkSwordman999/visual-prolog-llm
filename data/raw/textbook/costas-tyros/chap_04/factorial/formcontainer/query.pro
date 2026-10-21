/*****************************************************************************

                         Utah State University

******************************************************************************/

implement query
    inherits formWindow
    open core, vpiDomains

constants
    className = "formcontainer/query".
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
    onFactorialClick : button::clickResponder.
clauses
    onFactorialClick(_S) = button::defaultAction() :-
        fn::calculate(edit_ctl:getText()).

% This code is maintained automatically, do not update it manually. 01:05:60-3.8.2007
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    edit_ctl : editControl.
    factorial_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("query"),
        setRect(rct(50,40,258,140)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(16, 72),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(80, 72),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(140, 72),
        help_ctl:setAnchors([control::right,control::bottom]),
        edit_ctl := editControl::new(This),
        edit_ctl:setText(""),
        edit_ctl:setPosition(8, 10),
        edit_ctl:setWidth(60),
        factorial_ctl := button::new(This),
        factorial_ctl:setText("Factorial"),
        factorial_ctl:setPosition(84, 10),
        factorial_ctl:setClickResponder(onFactorialClick).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement query
