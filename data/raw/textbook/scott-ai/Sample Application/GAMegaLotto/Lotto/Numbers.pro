/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/

implement numbers
    inherits formWindow
    open core, vpiDomains

constants
    className = "Lotto/numbers".
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
    set_form_text_for_LCN(L):-
      staticText1_ctl:setText(L),
      update().                                          %to repaint

    set_form_text_for_MCN(M):-
      staticText3_ctl:setText(M),
      update().                                          %to repaint
      
    set_form_text_for_OCN(O):-
      staticText5_ctl:setText(O),
      update().                                          %to repaint
      
    set_form_text_for_RLCN(RLCN):-
      staticText7_ctl:setText(RLCN),
      update().                                          %to repaint
    
    set_form_text_for_RAN(R):-
      staticText9_ctl:setText(R),
      update().                                          %to repaint

predicates
    onSaveClick : button::clickResponder.
clauses
    onSaveClick(_Source) = button::defaultAction:-
          getNumbers::saveHistory().

predicates
    onAgainClick : button::clickResponder.
clauses
    onAgainClick(_Source) = button::noAction:-
        getNumbers::randomAgain(RL, R),
        staticText7_ctl:setText(RL),
        staticText9_ctl:setText(R),
        update().


% This code is maintained automatically, do not update it manually. 14:46:20-26.7.2009
facts
    again_ctl : button.
    save_ctl : button.
    staticText1_ctl : textControl.
    staticText3_ctl : textControl.
    staticText5_ctl : textControl.
    staticText7_ctl : textControl.
    staticText9_ctl : textControl.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("Numbers"),
        setRect(rct(50,40,282,160)),
        setDecoration(titlebar([closebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(resMenu(resourceIdentifiers::id_TaskMenu)),
        addShowListener(generatedOnShow),
        again_ctl := button::newOk(This),
        again_ctl:setText("&Again"),
        again_ctl:setPosition(56, 98),
        again_ctl:setAnchors([control::right,control::bottom]),
        again_ctl:setClickResponder(onAgainClick),
        save_ctl := button::newCancel(This),
        save_ctl:setText("&Save"),
        save_ctl:setPosition(128, 98),
        save_ctl:setAnchors([control::right,control::bottom]),
        save_ctl:setClickResponder(onSaveClick),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Least Called Numbers: "),
        StaticText_ctl:setPosition(36, 12),
        StaticText_ctl:setSize(80, 10),
        staticText1_ctl := textControl::new(This),
        staticText1_ctl:setText("Static text"),
        staticText1_ctl:setPosition(116, 12),
        staticText1_ctl:setSize(80, 10),
        StaticText2_ctl = textControl::new(This),
        StaticText2_ctl:setText("Most Called Numbers: "),
        StaticText2_ctl:setPosition(36, 28),
        StaticText2_ctl:setSize(80, 10),
        staticText3_ctl := textControl::new(This),
        staticText3_ctl:setText("Static text"),
        staticText3_ctl:setPosition(116, 28),
        staticText3_ctl:setSize(80, 10),
        StaticText4_ctl = textControl::new(This),
        StaticText4_ctl:setText("Oldest Called Numbers: "),
        StaticText4_ctl:setPosition(36, 44),
        StaticText4_ctl:setSize(80, 10),
        staticText5_ctl := textControl::new(This),
        staticText5_ctl:setText("Static text"),
        staticText5_ctl:setPosition(116, 44),
        staticText5_ctl:setSize(80, 10),
        StaticText6_ctl = textControl::new(This),
        StaticText6_ctl:setText("Random Least Called: "),
        StaticText6_ctl:setPosition(36, 60),
        StaticText6_ctl:setSize(80, 10),
        staticText7_ctl := textControl::new(This),
        staticText7_ctl:setText("Static text"),
        staticText7_ctl:setPosition(116, 60),
        staticText7_ctl:setSize(80, 10),
        StaticText8_ctl = textControl::new(This),
        StaticText8_ctl:setText("Random1: "),
        StaticText8_ctl:setPosition(36, 76),
        StaticText8_ctl:setSize(80, 10),
        staticText9_ctl := textControl::new(This),
        staticText9_ctl:setText("Static text"),
        staticText9_ctl:setPosition(116, 76),
        staticText9_ctl:setSize(80, 10).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement numbers
