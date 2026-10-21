/*****************************************************************************

                         Utah State University

******************************************************************************/

implement midiform
    inherits formWindow
    open core, vpiDomains

constants
    className = "midiform/midiform".
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
    onSaveClick(_Source) = button::defaultAction :-
       Txt= editorControl_ctl:getEntireText(),
       S= list::removeAll(string::split(Txt, "\n "), ""),
       FName= vpiCommonDialogs::getFileName("*.mid",
                                 ["Midi", "*.mid"],
                                 "Save in MIDI format", [], ".",  _X), !,
        midi::generate(FName,  S).
    onSaveClick(_Source) = button::defaultAction.
% This code is maintained automatically, do not update it manually. 18:34:35-15.8.2007
facts
    editorControl_ctl : editorcontrol.
    save_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("midiform"),
        setRect(rct(50,40,290,160)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        editorControl_ctl := editorcontrol::new(This),
        editorControl_ctl:setPosition(4, 4),
        editorControl_ctl:setSize(224, 88),
        save_ctl := button::new(This),
        save_ctl:setText("Save"),
        save_ctl:setPosition(12, 104),
        save_ctl:setClickResponder(onSaveClick).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement midiform
