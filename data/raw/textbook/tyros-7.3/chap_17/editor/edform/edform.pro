/*****************************************************************************

                         Utah State University

******************************************************************************/

implement edform
    inherits formWindow
    open core, vpiDomains

constants
    className = "edform/edform".
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
    onSaveClick : button::clickResponder.
clauses
   onSaveClick(_Source) = button::defaultAction() :-
     Txt= editorControl_ctl:getEntireText(),
     FName= vpiCommonDialogs::getFileName("*.*", ["Text", "*.txt"], "Save", [], ".",  _X),  !,
     file::writeString(FName, Txt).
   onSaveClick(_Source) = button::defaultAction().


predicates
    onLoadClick : button::clickResponder.
clauses
  onLoadClick(_Source) = button::defaultAction() :-
     FName= vpiCommonDialogs::getFileName("*.*", ["Text", "*.txt"], "Save", [], ".",  _X),  
     file::existFile(FName),
       !,
     Str= file::readString(FName, _IsUnicodeFile),
     editorControl_ctl:pasteStr(1, Str).
  onLoadClick(_Source) = button::defaultAction().

% This code is maintained automatically, do not update it manually. 11:39:34-14.8.2007
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    save_ctl : button.
    load_ctl : button.
    editorControl_ctl : editorcontrol.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
     %    setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("edform"),
        setRect(rct(50,40,330,210)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(4, 150),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(108, 150),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(216, 150),
        help_ctl:setAnchors([control::right,control::bottom]),
        save_ctl := button::new(This),
        save_ctl:setText("Save"),
        save_ctl:setPosition(4, 130),
        save_ctl:setClickResponder(onSaveClick),
        load_ctl := button::new(This),
        load_ctl:setText("Load"),
        load_ctl:setPosition(216, 130),
        load_ctl:setClickResponder(onLoadClick),
        editorControl_ctl := editorcontrol::new(This),
        editorControl_ctl:setPosition(8, 6),
        editorControl_ctl:setSize(260, 118).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement edform
