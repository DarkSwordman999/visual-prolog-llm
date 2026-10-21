/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement addPerson
    inherits dialog
    open core, vpiDomains

constants
    className = "forms/addPerson".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    display(Parent) = Dialog :-
        Dialog = new(Parent),
        Dialog:show().

clauses
    new(Parent) :-
        dialog::new(Parent),
        generatedInitialize().

predicates
    onOkClick : button::clickResponder.
	clauses
	    onOkClick(_Source) = button::defaultAction() :-
	        Name = name_ctl:gettext(),
	        Weight = toTerm(weight_ctl:gettext()),
	        Length = toTerm(length_ctl:gettext()),
	        IQ = toTerm(iq_ctl:gettext()),
	        person::addPerson(Name, Weight, Length, IQ).

% This code is maintained automatically, do not update it manually. 12:38:53-22.6.2009
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    name_ctl : editControl.
    weight_ctl : editControl.
    length_ctl : editControl.
    iq_ctl : editControl.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("addPerson"),
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
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(176, 98),
        help_ctl:setAnchors([control::right,control::bottom]),
        name_ctl := editControl::new(This),
        name_ctl:setText("Type a name"),
        name_ctl:setPosition(88, 12),
        weight_ctl := editControl::new(This),
        weight_ctl:setText("75"),
        weight_ctl:setPosition(88, 32),
        length_ctl := editControl::new(This),
        length_ctl:setText("180"),
        length_ctl:setPosition(88, 52),
        iq_ctl := editControl::new(This),
        iq_ctl:setText("100"),
        iq_ctl:setPosition(88, 72),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Name"),
        StaticText_ctl:setPosition(20, 12),
        StaticText1_ctl = textControl::new(This),
        StaticText1_ctl:setText("Weight"),
        StaticText1_ctl:setPosition(20, 32),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("Length"),
        StaticText2_ctl:setPosition(20, 53),
        StaticText3_ctl = textControl::new(This),
        StaticText3_ctl:setText("IQ"),
        StaticText3_ctl:setPosition(20, 74).
% end of automatic code
end implement addPerson
