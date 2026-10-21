/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement taskWindow
    inherits applicationWindow
    open core, vpiDomains

constants
    className = "TaskWindow/taskWindow".
    classVersion = "".

clauses
    classInfo(className, classVersion).

constants
    mdiProperty : boolean = true.
clauses
    new():-
        applicationWindow::new(),
        generatedInitialize().

predicates
    onShow : window::showListener.
clauses
    onShow(_, _CreationData):-
        _MessageForm = messageForm::display(This).

predicates
    onDestroy : window::destroyListener.
clauses
    onDestroy(_).

predicates
    onHelpAbout : window::menuItemListener.
clauses
    onHelpAbout(TaskWin, _MenuTag):-
        _AboutDialog = aboutDialog::display(TaskWin).

predicates
    onFileExit : window::menuItemListener.
clauses
    onFileExit(_, _MenuTag):-
        close().

predicates
    onSizeChanged : window::sizeListener.
clauses
    onSizeChanged(_):-
        vpiToolbar::resize(getVPIWindow()).

	predicates
	    oncreateperson : window::menuItemListener.
	clauses
	    oncreateperson(Source, _MenuTag) :-
	        NewForm = createperson::new(Source),
	        NewForm:show().

	predicates
	    onshowall : window::menuItemListener.
	clauses
	    onshowall(_Source, _MenuTag) :-
	        person::showAllPersons().

	predicates
	    onshowsingle : window::menuItemListener.
	clauses
	    onshowsingle(_Source, _MenuTag) :-
	        person::getAllNames(Nameslist),
	        b_true = vpiCommonDialogs::listSelect("Select a name", NamesList, 0, Name, _Index), !,
	        person::showSinglePerson(Name).
	    onshowsingle(_Source, _MenuTag) :- !.

	predicates
	    ondeleteperson : window::menuItemListener.
	clauses
	    ondeleteperson(_Source, _MenuTag) :-
	        person::getAllNames(Nameslist),
	        b_true = vpiCommonDialogs::listSelect("Select a name", NamesList, 0, Name, _Index), !,
	        person::deletePerson(Name).
	    ondeleteperson(_,_).

% This code is maintained automatically, do not update it manually. 09:41:50-26.6.2009
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("ch08classDB"),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings]),
        setMdiProperty(mdiProperty),
        menuSet(resMenu(resourceIdentifiers::id_TaskMenu)),
        addShowListener(generatedOnShow),
        addShowListener(onShow),
        addSizeListener(onSizeChanged),
        addDestroyListener(onDestroy),
        addMenuItemListener(resourceIdentifiers::id_help_about, onHelpAbout),
        addMenuItemListener(resourceIdentifiers::id_file_exit, onFileExit),
        addMenuItemListener(resourceIdentifiers::id_createperson, oncreateperson),
        addMenuItemListener(resourceIdentifiers::id_showall, onshowall),
        addMenuItemListener(resourceIdentifiers::id_showsingle, onshowsingle),
        addMenuItemListener(resourceIdentifiers::id_deleteperson, ondeleteperson).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
