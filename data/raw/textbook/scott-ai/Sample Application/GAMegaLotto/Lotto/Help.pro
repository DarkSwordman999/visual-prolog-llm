/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/

implement help
    inherits formWindow
    open core, vpiDomains

constants
    className = "Lotto/help".
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

clauses
    set_form_text(Help):-
      staticText_ctl:setForegroundColor(color_Blue ),
      staticText_ctl:setText(Help),
      update().                                          %to repaint

predicates
    onExitClick : button::clickResponder.
clauses
    onExitClick(_Source) = button::defaultAction.

% This code is maintained automatically, do not update it manually. 13:36:20-5.9.2009
facts
    staticText_ctl : textControl.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("Help"),
        setRect(rct(50,40,458,438)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_NoClipSiblings,wsf_VScroll]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        staticText_ctl := textControl::new(This),
        staticText_ctl:setText("Static text"),
        staticText_ctl:setPosition(4, 2),
        staticText_ctl:setSize(400, 392).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement help
