/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/

implement taskWindow
    inherits applicationWindow
    open core, vpiDomains, lottoDomains

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
    onImportData : window::menuItemListener.
clauses
    onImportData(_Source, _MenuTag) :-
        convertData::checkImportStatus(S), S=false,
        convertData::getData(), !.
    onImportData(_Source, _MenuTag) :-
        vpiCommonDialogs::note("Lottery Data has already been Imported."), !.

predicates
    onGetNumbers : window::menuItemListener.
clauses
    onGetNumbers(_Source, _MenuTag) :-
        convertdata::checkImportStatus(S), S=true,
        Form = numbers::new(This),
        Form:show(),
        getNumbers::history([L, M, O, RL, R]),
        Form:set_form_text_for_LCN(L),
        Form:set_form_text_for_MCN(M),
        Form:set_form_text_for_OCN(O),
        Form:set_form_text_for_RLCN(RL),
        Form:set_form_text_for_RAN(R), !.
    onGetNumbers(_Source, _MenuTag) :-
        vpiCommonDialogs::note("Lottery Data has not been Imported Yet, Import it first."), !.

predicates
    onHelpDownloadProcedure : window::menuItemListener.
clauses
    onHelpDownloadProcedure(Source, _MenuTag):-
        HelpWindow = helpWindow::new(Source, lottoHelpFile),
        HelpWindow:show().

% This code is maintained automatically, do not update it manually. 19:09:58-23.12.2009
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("Lotto"),
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
        addMenuItemListener(resourceIdentifiers::id_import_data, onImportData),
        addMenuItemListener(resourceIdentifiers::id_get_numbers, onGetNumbers),
        addMenuItemListener(resourceIdentifiers::id_help_download_procedure, onHelpDownloadProcedure).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
