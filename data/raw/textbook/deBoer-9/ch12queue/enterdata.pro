/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
implement enterdata
    inherits formWindow
    open vpiDomains

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

predicates
    onOkClick : button::clickResponder.
clauses
    onOkClick(_Source) = button::defaultAction :-
        Name = name_ctl:gettext(),
        Amount = toterm(amount_ctl:gettext()),
        classQ::push(Name, Amount),
        stdIO::write("q(", Name, ", ", Amount, ") is pushed at the end of the queue"), stdIO::nl.

% This code is maintained automatically, do not update it manually. 14:10:29-30.6.2009
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    name_ctl : editControl.
    amount_ctl : editControl.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("enterdata"),
        setRect(rct(50,40,290,160)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(48, 98),
        ok_ctl:setAnchors([control::right,control::bottom]),
        ok_ctl:setClickResponder(onOkClick),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(112, 98),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(176, 98),
        help_ctl:setAnchors([control::right,control::bottom]),
        name_ctl := editControl::new(This),
        name_ctl:setText("Edit"),
        name_ctl:setPosition(112, 34),
        amount_ctl := editControl::new(This),
        amount_ctl:setText("Edit"),
        amount_ctl:setPosition(112, 54),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("New item for the queue"),
        StaticText_ctl:setPosition(48, 6),
        StaticText_ctl:setSize(104, 10),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Name"),
        StaticText1_ctl:setPosition(48, 32),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("Amount"),
        StaticText2_ctl:setPosition(48, 54).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement enterdata
