/*****************************************************************************

                         Utah State University

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
    onFileNew : window::menuItemListener.
clauses
    onFileNew(S, _MenuTag) :-
         W= query::new(S), W:show().

predicates
    onPresentOpen : window::menuItemListener.
clauses
    onPresentOpen(_Source, _MenuTag) :-
          File= vpiCommonDialogs::getFileName("*.prs", ["Present", "*.prs"], "Load Verbs",  [], ".",  _X), !,
          verbs::read(File).
    onPresentOpen(_Source, _MenuTag).

predicates
    onDeclensionOpen : window::menuItemListener.
clauses
    onDeclensionOpen(_Source, _MenuTag) :-
          File= vpiCommonDialogs::getFileName("*.dcl", ["Present", "*.dcl"], "Load Declensions",  [], ".",  _X), !,
          cases::read(File).
     onDeclensionOpen(_Source, _MenuTag).
% This code is maintained automatically, do not update it manually. 12:05:00-6.8.2007
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("skinner"),
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
        addMenuItemListener(resourceIdentifiers::id_file_new, onFileNew),
        addMenuItemListener(resourceIdentifiers::id_present_open, onPresentOpen),
        addMenuItemListener(resourceIdentifiers::id_declension_open, onDeclensionOpen).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
