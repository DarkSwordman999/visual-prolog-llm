/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement taskWindow
    inherits applicationWindow
    open core, vpiDomains, vpiCommonDialogs
    
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
    onMessagesWritenote1 : window::menuItemListener.
clauses
	clauses
	    onMessagesWritenote1(_Source, _MenuTag) :-
	        note("This is a message").


predicates
    onMessagesWriteerror : window::menuItemListener.
clauses
    onMessagesWriteerror(_Source, _MenuTag) :-
        error("This is an error message").


predicates
    onMessagesWritemessagebox : window::menuItemListener.
clauses
    onMessagesWritemessagebox(_Source, _MenuTag) :-
        Answer = messageBox("TitleString", "Message line",
            mesbox_iconExclamation,
            mesbox_buttonsYesNo,
            mesbox_defaultSecond,
            mesbox_suspendApplication),
        note("You pressed button number ...", tostring(Answer)).


predicates
    onMessagesListselect : window::menuItemListener.
clauses
    onMessagesListselect(_Source, _MenuTag) :-
        b_true = listSelect("Title", ["Choice1", "Choice2", "Choice3"],0,SelectedString, SelectedIndex),
        !,
        note("Your selection is ...", SelectedString),
        note(" ... with index ...",tostring(SelectedIndex)).
    onMessagesListselect(_Source, _MenuTag).


% This code is maintained automatically, do not update it manually. 16:32:28-18.6.2009
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("ch03p01"),
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
        addMenuItemListener(resourceIdentifiers::id_messages_writenote1, onMessagesWritenote1),
        addMenuItemListener(resourceIdentifiers::id_messages_writeerror, onMessagesWriteerror),
        addMenuItemListener(resourceIdentifiers::id_messages_writemessagebox, onMessagesWritemessagebox),
        addMenuItemListener(resourceIdentifiers::id_messages_listselect, onMessagesListselect).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
