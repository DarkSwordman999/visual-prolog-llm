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
    onDestroy(_) :- emails::data_base_close().
    
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

class predicates
   createNewDB:(string FNAME).
predicates
    oncreate : window::menuItemListener.
clauses
    oncreate(_Source, _MenuTag) :-
         FName= vpiCommonDialogs::getFileName("*.*", 
                         ["Email", "*.dbs"], 
                         "Create", [], ".",  _X),  !,
         createNewDB(FName).
   oncreate(_, _).

   createNewDB(Fname) :-  file::existfile(Fname), !.
   createNewDB(Fname) :-  emails::data_base_create(Fname).
   
class predicates
   openDB:(string FNAME).
predicates
    onFileOpen : window::menuItemListener.
clauses
    onFileOpen(_Source, _MenuTag) :-
           FName= vpiCommonDialogs::getFileName("*.*", 
	                            ["Email", "*.dbs"], 
                         "Open", [], ".",  _X), !,
          openDB(FName).
    onFileOpen(_, _).

    openDB(Fname) :- file::existfile(Fname), !,
          emails::data_base_open(Fname).
    openDB(_).
predicates
    onFileNew : window::menuItemListener.
clauses
    onFileNew(S, _MenuTag) :-
      X= insertForm::new(S), X:show().

% This code is maintained automatically, do not update it manually. 20:04:57-2.8.2007
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("emailBook"),
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
        addMenuItemListener(resourceIdentifiers::id_create, oncreate),
        addMenuItemListener(resourceIdentifiers::id_file_open, onFileOpen),
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
