/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement createPerson
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
	    onCreateObjectClick : button::clickResponder.
	clauses
	    onCreateObjectclick(_Source) = button::defaultAction() :-
	        Name = name_ctl:getText(),
	        _NewPerson = person::new(Name).

% This code is maintained automatically, do not update it manually. 16:33:45-25.6.2009
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    name_ctl : editControl.
    createObject_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("createPerson"),
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
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(112, 98),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(176, 98),
        help_ctl:setAnchors([control::right,control::bottom]),
        name_ctl := editControl::new(This),
        name_ctl:setText("Type a name"),
        name_ctl:setPosition(48, 24),
        name_ctl:setWidth(56),
        createObject_ctl := button::new(This),
        createObject_ctl:setText("Create object"),
        createObject_ctl:setPosition(112, 22),
        createObject_ctl:setClickResponder(onCreateObjectClick).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement createPerson
