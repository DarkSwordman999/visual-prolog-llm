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
    onQPush : window::menuItemListener.
clauses
    onQPush(Source, _MenuTag) :-
        NewForm = enterdata::new(Source), NewForm:show().

predicates
    onQPeek : window::menuItemListener.
clauses
    onQPeek(_Source, _MenuTag) :-
        classQ::peek(Name, Amount),
        Name <>"0", !,
        stdIO::write("q(", Name, ", ", Amount, ") is first in the queue"),
        stdIO::nl.
    onQPeek(_Source, _MenuTag) :-
        stdIO::write("Queue is empty"),
        stdIO::nl.

predicates
    onQPop : window::menuItemListener.
clauses
    onQPop(_Source, _MenuTag) :-
        classQ::pop(Name, Amount),
        Name <>"0", !,
        stdIO::write("q(", Name, ", ", Amount, ") is first in the queue and is retracted"),
        stdIO::nl.
    onQPop(_Source, _MenuTag) :-
        stdIO::write("Queue is empty"),
        stdIO::nl.

predicates
    onQListq : window::menuItemListener.
clauses
    onQListq(_Source, _MenuTag) :-
        stdIO::write("The queue contains:"), stdIO::nl,
        classQ::listQ().

predicates
    onQDuplicate : window::menuItemListener.
clauses
    onQDuplicate(_Source, _MenuTag) :-
        classQ::duplicate(Name, Address),
        Name <> "0", !,
        stdIO::write(Name, " ", Address, " has been duplicated"), stdIO::nl.
    onQDuplicate(_Source, _MenuTag) :-
        stdIO::write("Queue is empty, nothing to duplicate"), stdIO::nl.

predicates
    onQSwap : window::menuItemListener.
clauses
    onQSwap(_Source, _MenuTag) :-
        classQ::swap(Name1, Address1, Name2, Address2),
        Name1 <> "0", !,
        stdIO::write("(",Name1, " ", Address1, ") and (", Name2, "", Address2, ") have been swapped"), stdIO::nl.
    onQSwap(_Source, _MenuTag) :-
        stdIO::write("Queue contains less than two items. Nothing to swap"), stdIO::nl.

% This code is maintained automatically, do not update it manually. 14:28:40-30.6.2009
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("ch12queue"),
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
        addMenuItemListener(resourceIdentifiers::id_q_push, onQPush),
        addMenuItemListener(resourceIdentifiers::id_q_peek, onQPeek),
        addMenuItemListener(resourceIdentifiers::id_q_pop, onQPop),
        addMenuItemListener(resourceIdentifiers::id_q_listq, onQListq),
        addMenuItemListener(resourceIdentifiers::id_q_duplicate, onQDuplicate),
        addMenuItemListener(resourceIdentifiers::id_q_swap, onQSwap).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
