/*****************************************************************************

                        Copyright © 

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
        
% This code is maintained automatically, do not update it manually. 13:56:37-31.8.2010
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
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("query"),
        setRect(rct(50,40,246,106)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(4, 24),
        ok_ctl:setSize(56, 16),
        ok_ctl:defaultHeight := false(),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(64, 24),
        cancel_ctl:setSize(56, 16),
        cancel_ctl:defaultHeight := false(),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(124, 24),
        help_ctl:setSize(56, 16),
        help_ctl:defaultHeight := false(),
        help_ctl:setAnchors([control::right,control::bottom]),
        edit_ctl := editControl::new(This),
        edit_ctl:setText(""),
        edit_ctl:setPosition(4, 4),
        edit_ctl:setWidth(72),
        factorial_ctl := button::new(This),
        factorial_ctl:setText("Factorial"),
        factorial_ctl:setPosition(80, 2),
        factorial_ctl:setSize(56, 16),
        factorial_ctl:defaultHeight := true(),
        factorial_ctl:setClickResponder(onFactorialClick).
% end of automatic code
end implement query
