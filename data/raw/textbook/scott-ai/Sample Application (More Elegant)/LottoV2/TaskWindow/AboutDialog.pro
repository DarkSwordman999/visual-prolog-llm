/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/

implement aboutDialog
    inherits dialog
    open core, vpiDomains

constants
    className = "TaskWindow/aboutDialog".
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

% This code is maintained automatically, do not update it manually. 11:18:40-27.12.2009
facts
    version1_ctl : versioncontrol.
    version3_ctl : versioncontrol.
    version2_ctl : versioncontrol.
    version_ctl : versioncontrol.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("About"),
        setRect(rct(122,26,322,130)),
        setModal(true),
        setDecoration(titlebar([closebutton()])),
        setState([wsf_NoClipSiblings]),
        ButtonOk = button::newOk(This),
        ButtonOk:setText("&OK"),
        ButtonOk:setPosition(72, 86),
        GroupBox = groupBox::new(This),
        GroupBox:setText(""),
        GroupBox:setPosition(4, 22),
        GroupBox:setSize(192, 60),
        version1_ctl := versioncontrol::new(GroupBox),
        version1_ctl:setPosition(3, 12),
        version1_ctl:setSize(184, 10),
        version1_ctl:setText("by"),
        version1_ctl:setAlignment(vpiDomains::alignCenter),
        version3_ctl := versioncontrol::new(GroupBox),
        version3_ctl:setPosition(3, 36),
        version3_ctl:setSize(184, 10),
        version3_ctl:setText("December 2009"),
        version3_ctl:setAlignment(vpiDomains::alignCenter),
        version2_ctl := versioncontrol::new(GroupBox),
        version2_ctl:setPosition(3, 24),
        version2_ctl:setSize(184, 10),
        version2_ctl:setText("Randall Scott"),
        version2_ctl:setAlignment(vpiDomains::alignCenter),
        version_ctl := versioncontrol::new(GroupBox),
        version_ctl:setPosition(3, 0),
        version_ctl:setSize(184, 10),
        version_ctl:setText("Georgia Mega Lottery"),
        version_ctl:setAlignment(vpiDomains::alignCenter),
        IconProject = iconControl::new(This),
        IconProject:setIcon(application_icon),
        IconProject:setPosition(12, 4).
% end of automatic code
end implement aboutDialog
