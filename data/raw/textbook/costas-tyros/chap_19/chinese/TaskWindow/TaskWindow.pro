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
       W= chineseForm::new(S), W:show().
       
predicates
    onFilePronunciationHowAreYou : window::menuItemListener.
clauses
    onFilePronunciationHowAreYou(_Source, _MenuTag) :-
            _ = multiMedia_native::sndPlaySound("howareu.wav",
                                       multiMedia_native::snd_ASync ).
          
predicates
    onFilePronunciationIAmFine : window::menuItemListener.
clauses
    onFilePronunciationIAmFine(_S, _MenuTag) :-
           _ = multiMedia_native::sndPlaySound("well.wav", multiMedia_native::snd_ASync ).

% This code is maintained automatically, do not update it manually. 17:49:27-9.8.2007
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("chinese"),
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
        addMenuItemListener(resourceIdentifiers::id_file_pronunciation_how_are_you, onFilePronunciationHowAreYou),
        addMenuItemListener(resourceIdentifiers::id_file_pronunciation_i_am_fine, onFilePronunciationIAmFine).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
