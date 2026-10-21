/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement taskWindow
    inherits applicationWindow
    open vpiDomains

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
    onDatabaseFilldatabase : window::menuItemListener.
clauses
    onDatabaseFilldatabase(_Source, _MenuTag) :-
        person::filldatabase().

predicates
    onDatabaseListdatabase : window::menuItemListener.
clauses
    onDatabaseListdatabase(_Source, _MenuTag) :-
        person::listDatabase().

predicates
    onDatabaseAddPerson : window::menuItemListener.
clauses
    onDatabaseAddPerson(Source, _MenuTag) :-
        NewDialog = addPerson::new(Source),
        NewDialog:show().

predicates
    onDatabaseDeletePerson : window::menuItemListener.
clauses
    onDatabaseDeletePerson(Source, _MenuTag) :-
        NewDialog = deletePerson::new(Source),
        NewDialog:show().

predicates
    onDatabaseChangePerson : window::menuItemListener.
clauses
    onDatabaseChangePerson(Source, _MenuTag) :-
        NewDialog = changePerson::new(Source),
        NewDialog:show().

predicates
    onDatabaseConsultdatabase : window::menuItemListener.
clauses
    onDatabaseConsultdatabase(_Source, _MenuTag) :-
        person::consultDatabase().

predicates
    onDatabaseSavedatabase : window::menuItemListener.
clauses
    onDatabaseSavedatabase(_Source, _MenuTag) :-
        person::saveDatabase().

% This code is maintained automatically, do not update it manually. 10:15:04-23.6.2009
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("ch07db"),
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
        addMenuItemListener(resourceIdentifiers::id_database_filldatabase, onDatabaseFilldatabase),
        addMenuItemListener(resourceIdentifiers::id_database_listdatabase, onDatabaseListdatabase),
        addMenuItemListener(resourceIdentifiers::id_database_add_person, onDatabaseAddPerson),
        addMenuItemListener(resourceIdentifiers::id_database_deleteperson, onDatabaseDeleteperson),
        addMenuItemListener(resourceIdentifiers::id_database_change_person, onDatabaseChangePerson),
        addMenuItemListener(resourceIdentifiers::id_database_consult_database, onDatabaseConsultDatabase),
        addMenuItemListener(resourceIdentifiers::id_database_save_database, onDatabaseSaveDatabase).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
