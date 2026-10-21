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
	    onCreateButtonClick : button::clickResponder.
	clauses
	    onCreateButtonClick(_Source) = button::defaultAction :-
	        Name = name_ctl:getText(),
	        _NewPerson = person::new(Name).

% This code is maintained automatically, do not update it manually. 09:55:37-26.6.2009
facts
    close_ctl : button.
    name_ctl : editControl.
    createButton_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("createPerson"),
        setRect(rct(50,40,278,136)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        close_ctl := button::newOk(This),
        close_ctl:setText("Close"),
        close_ctl:setPosition(148, 60),
        close_ctl:setAnchors([control::right,control::bottom]),
        name_ctl := editControl::new(This),
        name_ctl:setText("Type a name"),
        name_ctl:setPosition(80, 20),
        createButton_ctl := button::new(This),
        createButton_ctl:setText("Create"),
        createButton_ctl:setPosition(148, 20),
        createButton_ctl:setClickResponder(onCreateButtonClick),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Name"),
        StaticText_ctl:setPosition(16, 20).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement createPerson
