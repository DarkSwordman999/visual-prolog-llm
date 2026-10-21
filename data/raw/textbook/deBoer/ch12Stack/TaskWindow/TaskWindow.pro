/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

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
    onStackPush : window::menuItemListener.
clauses
    onStackPush(_Source, _MenuTag) :-
        Element = vpiCommonDialogs::getString("Give a string", "input a string", "DefaultString"), !,
        stackprocs::push(Element),
        stdIO::write("Element ", Element, " has been pushed"), stdIO::nl.
    onStackPush(_Source, _MenuTag).

predicates
    onStackPeek : window::menuItemListener.
clauses
    onStackPeek(_Source, _MenuTag) :-
        stackprocs::peek(Element), !,
        stdIO::write("the peeked element is ", Element), stdIO::nl.
    onStackPeek(_Source, _MenuTag).


predicates
    onStackPop : window::menuItemListener.
clauses
    onStackPop(_Source, _MenuTag) :-
        stackprocs::pop(Element), !,
        stdIO::write("the popped element is ", Element), stdIO::nl.
    onStackPop(_Source, _MenuTag).

predicates
    onStackDup : window::menuItemListener.
clauses
    onStackDup(_Source, _MenuTag) :-
        stackprocs::dup(), !,
        stdIO::write("The top element has been duplicated"), stdIO::nl.
    onStackDup(_Source, _MenuTag).

predicates
    onStackSwap : window::menuItemListener.
clauses
    onStackSwap(_Source, _MenuTag) :-
        stackprocs::swap(), !,
        stdIO::write("The top elements have been swapped"), stdIO::nl.
    onStackSwap(_Source, _MenuTag).

predicates
    onStackShowstack : window::menuItemListener.
clauses
    onStackShowstack(_Source, _MenuTag):-
        stackprocs::showstack(),
        stdIO::nl.

% This code is maintained automatically, do not update it manually. 15:41:28-2.10.2008
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("ch12Stack"),
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
        addMenuItemListener(resourceIdentifiers::id_stack_push, onStackPush),
        addMenuItemListener(resourceIdentifiers::id_stack_peek, onStackPeek),
        addMenuItemListener(resourceIdentifiers::id_stack_pop, onStackPop),
        addMenuItemListener(resourceIdentifiers::id_stack_dup, onStackDup),
        addMenuItemListener(resourceIdentifiers::id_stack_swap, onStackSwap),
        addMenuItemListener(resourceIdentifiers::id_stack_showstack, onStackShowstack).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
