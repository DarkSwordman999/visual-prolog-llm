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
  onFileNew(_Source, _MenuTag) :-
    PW=vpi::printStartJob("Recoreco"),
    _HRES   = vpi::winGetAttrVal(PW,attr_printer_hres),
    VRES   = vpi::winGetAttrVal(PW,attr_printer_vres),
    V_SCR_RES=vpi::winGetAttrVal(PW,attr_screen_vres),
    FNT=vpi::fontCreate(ff_Fixed,[], VRES*40 div V_SCR_RES),
    vpi::winSetFont(PW,FNT),
    vpi::printStartPage(PW),
    vpi::drawText(PW, 100, 200, "Before the sunset!"),
    vpi::printEndPage(PW),
    vpi::printEndJob(PW).

% This code is maintained automatically, do not update it manually. 00:41:57-2.8.2007
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("testPrt"),
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
        addMenuItemListener(resourceIdentifiers::id_file_new, onFileNew).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
