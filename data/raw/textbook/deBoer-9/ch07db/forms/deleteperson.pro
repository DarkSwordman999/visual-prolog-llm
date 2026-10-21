/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement deletePerson
    inherits dialog
    open vpiDomains, list

clauses
    display(Parent) = Dialog :-
        Dialog = new(Parent),
        Dialog:show().

clauses
    new(Parent) :-
        dialog::new(Parent),
        generatedInitialize(),
        person::getAllNames(NameList),
        SingletonList = removeDuplicates(NameList),
        listBox_ctl:addList(SingletonList).

predicates
    onListboxSelectionChanged : listControl::selectionChangedListener.
clauses
    onListboxSelectionChanged(Source) :-
        [Name | _T] = Source:getSelectedItems(),
        person::getSomeIDs(Name, IDList),
        idBox_ctl:clearAll(),
        id_ctl:setText(" "),
        name_ctl:setText(" "),
        idBox_ctl:addList(IDList), !.
    onListBoxSelectionChanged(_Source).

predicates
    onIdBoxSelectionChanged : listControl::selectionChangedListener.
clauses
    onIdBoxSelectionChanged(Source) :-
        [ID | _T] = Source:getSelectedItems(),
        person::getPerson(ID, Name, _, _, _),
        id_ctl:setText(ID),
        name_ctl:setText(Name), !.
  onIdboxSelectionChanged(_Source).

predicates
    onOkClick : button::clickResponder.
clauses
    onOkClick(_Source) = button::defaultAction() :-
        ID = id_ctl:getText(),
        person::deletePerson(ID).

predicates
    onCancelClick : button::clickResponder.
clauses
    onCancelClick(_Source) = button::defaultAction :-
        vpiCommonDialogs::note("No deletions").

% This code is maintained automatically, do not update it manually. 09:42:43-23.6.2009
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    name_ctl : editControl.
    id_ctl : editControl.
    listbox_ctl : listBox.
    idbox_ctl : listBox.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("deletePerson"),
        setRect(rct(50,40,290,160)),
        setModal(true),
        setDecoration(titlebar([closebutton()])),
        setState([wsf_NoClipSiblings]),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(48, 98),
        ok_ctl:setAnchors([control::right,control::bottom]),
        ok_ctl:setClickResponder(onOkClick),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(112, 98),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl:setClickResponder(onCancelClick),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(176, 98),
        help_ctl:setAnchors([control::right,control::bottom]),
        name_ctl := editControl::new(This),
        name_ctl:setText("Edit"),
        name_ctl:setPosition(188, 26),
        name_ctl:setReadOnly(),
        id_ctl := editControl::new(This),
        id_ctl:setText(""),
        id_ctl:setPosition(188, 48),
        id_ctl:setReadOnly(),
        listbox_ctl := listBox::new(This),
        listbox_ctl:setPosition(20, 36),
        listbox_ctl:addSelectionChangedListener(onListboxSelectionChanged),
        idbox_ctl := listBox::new(This),
        idbox_ctl:setPosition(88, 36),
        idbox_ctl:addSelectionChangedListener(onIdboxSelectionChanged),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Choose a Person"),
        StaticText_ctl:setPosition(12, 14),
        StaticText_ctl:setSize(56, 10),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Choose an ID"),
        StaticText1_ctl:setPosition(88, 14),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("To be deleted"),
        StaticText2_ctl:setPosition(172, 8),
        StaticText3_ctl = textControl::new(This),
        StaticText3_ctl:setText("Name"),
        StaticText3_ctl:setPosition(152, 28),
        StaticText3_ctl:setSize(24, 10),
        StaticText4_ctl = textControl::new(This),
        StaticText4_ctl:setText("ID"),
        StaticText4_ctl:setPosition(152, 50),
        StaticText4_ctl:setSize(24, 10).
% end of automatic code
end implement deletePerson
