/*****************************************************************************

                         Utah State University

******************************************************************************/

implement insertForm
    inherits formWindow
    open core, vpiDomains

constants
    className = "insertForm/insertForm".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

predicates
    onListEditShow : window::showListener.
clauses
    onListEditShow(_Source, _CreationData) :-
          WlboxHandle=listEdit_ctl:tryGetVpiWindow(), !,
          vpi::lboxAdd(WlboxHandle, ["Person", "Commerce"]).
    onListEditShow(_, _).

predicates
    onSaveClick : button::clickResponder.
clauses
  onSaveClick(_Source) = button::defaultAction() :-
         Key= key_ctl:getText(),
         Email= address_ctl:getText(),
         T= listEdit_ctl:getText(),
         emails::insert_info(Key, Email, T).

predicates
    onListClick : button::clickResponder.
clauses
    onListClick(_Source) = button::defaultAction :-
        emails::db_list().
% This code is maintained automatically, do not update it manually. 19:54:12-2.8.2007
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    save_ctl : button.
    list_ctl : button.
    key_ctl : editControl.
    address_ctl : editControl.
    listEdit_ctl : listEdit.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("insertForm"),
        setRect(rct(50,40,250,196)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(8, 136),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(68, 136),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(128, 136),
        help_ctl:setAnchors([control::right,control::bottom]),
        save_ctl := button::new(This),
        save_ctl:setText("Save"),
        save_ctl:setPosition(8, 114),
        save_ctl:setClickResponder(onSaveClick),
        list_ctl := button::new(This),
        list_ctl:setText("List"),
        list_ctl:setPosition(128, 114),
        list_ctl:setClickResponder(onListClick),
        key_ctl := editControl::new(This),
        key_ctl:setText(""),
        key_ctl:setPosition(8, 10),
        key_ctl:setWidth(180),
        address_ctl := editControl::new(This),
        address_ctl:setText(""),
        address_ctl:setPosition(8, 40),
        address_ctl:setWidth(180),
        listEdit_ctl := listEdit::new(This),
        listEdit_ctl:setText(""),
        listEdit_ctl:setPosition(8, 68),
        listEdit_ctl:setWidth(180),
        listEdit_ctl:addShowListener(onListEditShow).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement insertForm
