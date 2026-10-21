/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement changePerson
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
    onOkClick : button::clickResponder.
clauses
    onOkClick(_Source) = button::defaultAction() :-
        ID = id_ctl:getText(),
        Name = name_ctl:gettext(),
        Weight = toTerm(weight_ctl:gettext()),
        Length = toTerm(length_ctl:gettext()),
        IQ = toTerm(iq_ctl:gettext()),
        person::changePerson(ID, Name, Weight, Length, IQ).

predicates
    onListboxSelectionChanged : listControl::selectionChangedListener.
clauses
    onListboxSelectionChanged(Source) :-
        [Name | _T] = Source:getSelectedItems(),
        person::getSomeIDs(Name, IDList),
        idBox_ctl:clearAll(),
        id_ctl:setText(" "),
        name_ctl:setText(" "),
        weight_ctl:setText(" "),
        length_ctl:setText(" "),
        iq_ctl:setText(" "),
        idBox_ctl:addList(IDList), !.
    onListBoxSelectionChanged(_Source).

predicates
    onIdBoxSelectionChanged : listControl::selectionChangedListener.
clauses
    onIdboxSelectionChanged(Source) :-
        [ID | _T] = Source:getSelectedItems(),
        person::getPerson(ID, Name,Length,Weight,IQ),
        id_ctl:setText(ID),
        name_ctl:setText(Name),
        length_ctl:setText(toString(Length)),
        weight_ctl:setText(toString(Weight)),
        iq_ctl:setText(toString(IQ)), !.
	    onIdboxSelectionChanged(_Source).

% This code is maintained automatically, do not update it manually. 09:58:37-23.6.2009
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    id_ctl : editControl.
    name_ctl : editControl.
    weight_ctl : editControl.
    length_ctl : editControl.
    iq_ctl : editControl.
    listbox_ctl : listBox.
    idBox_ctl : listBox.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("changePerson"),
        setRect(rct(50,40,322,160)),
        setModal(true),
        setDecoration(titlebar([closebutton()])),
        setState([wsf_NoClipSiblings]),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(104, 102),
        ok_ctl:setSize(48, 12),
        ok_ctl:setAnchors([control::right,control::bottom]),
        ok_ctl:setClickResponder(onOkClick),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(160, 102),
        cancel_ctl:setSize(48, 12),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(216, 102),
        help_ctl:setSize(48, 12),
        help_ctl:setAnchors([control::right,control::bottom]),
        id_ctl := editControl::new(This),
        id_ctl:setText(""),
        id_ctl:setPosition(208, 6),
        id_ctl:setReadOnly(),
        name_ctl := editControl::new(This),
        name_ctl:setText(""),
        name_ctl:setPosition(208, 24),
        weight_ctl := editControl::new(This),
        weight_ctl:setText(""),
        weight_ctl:setPosition(208, 42),
        length_ctl := editControl::new(This),
        length_ctl:setText(""),
        length_ctl:setPosition(208, 60),
        iq_ctl := editControl::new(This),
        iq_ctl:setText(""),
        iq_ctl:setPosition(208, 80),
        listbox_ctl := listBox::new(This),
        listbox_ctl:setPosition(24, 30),
        listbox_ctl:addSelectionChangedListener(onListboxSelectionChanged),
        idBox_ctl := listBox::new(This),
        idBox_ctl:setPosition(84, 30),
        idBox_ctl:addSelectionChangedListener(onIdBoxSelectionChanged),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Choose a Name"),
        StaticText_ctl:setPosition(16, 6),
        StaticText_ctl:setSize(56, 10),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Choose an ID"),
        StaticText1_ctl:setPosition(84, 6),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("ID"),
        StaticText2_ctl:setPosition(148, 6),
        StaticText3_ctl = textControl::new(This),
        StaticText3_ctl:setText("Name"),
        StaticText3_ctl:setPosition(148, 24),
        StaticText4_ctl = textControl::new(This),
        StaticText4_ctl:setText("Weight"),
        StaticText4_ctl:setPosition(148, 42),
        StaticText5_ctl = textControl::new(This),
        StaticText5_ctl:setText("Length"),
        StaticText5_ctl:setPosition(148, 60),
        StaticText6_ctl = textControl::new(This),
        StaticText6_ctl:setText("IQ"),
        StaticText6_ctl:setPosition(148, 80).
% end of automatic code
end implement changePerson
