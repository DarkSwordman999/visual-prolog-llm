/*****************************************************************************

                        Copyright © 

******************************************************************************/

implement map
    inherits formWindow
    open core, vpiDomains

constants
    className = "map/map".
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
    onLoganClick : button::clickResponder.
clauses
    onLoganClick(S) = button::defaultAction() :-
        Parent= S:getParent(),
        P= Parent:getVPIWindow(),
        draw::drawThem(P, "Logan").

predicates
    onSaltlakeClick : button::clickResponder.
clauses
     onSaltlakeClick(S) = button::defaultAction() :-
        Parent= S:getParent(),
        P= Parent:getVPIWindow(),
        draw::drawThem(P, "Salt Lake").

predicates
    onProvoClick : button::clickResponder.
clauses
   onProvoClick(S) = button::defaultAction() :-
        Parent= S:getParent(),
        P= Parent:getVPIWindow(),
        draw::drawThem(P, "Provo").
        
% This code is maintained automatically, do not update it manually. 15:40:54-31.8.2010
facts
    logan_ctl : button.
    saltlake_ctl : button.
    provo_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("map"),
        setRect(rct(50,40,262,186)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        logan_ctl := button::new(This),
        logan_ctl:setText("Logan"),
        logan_ctl:setPosition(8, 112),
        logan_ctl:setSize(56, 16),
        logan_ctl:defaultHeight := true(),
        logan_ctl:setClickResponder(onLoganClick),
        saltlake_ctl := button::new(This),
        saltlake_ctl:setText("Salt Lake"),
        saltlake_ctl:setPosition(72, 112),
        saltlake_ctl:setSize(56, 16),
        saltlake_ctl:defaultHeight := true(),
        saltlake_ctl:setClickResponder(onSaltlakeClick),
        provo_ctl := button::new(This),
        provo_ctl:setText("Provo"),
        provo_ctl:setPosition(136, 112),
        provo_ctl:setSize(56, 16),
        provo_ctl:defaultHeight := true(),
        provo_ctl:setClickResponder(onProvoClick).
% end of automatic code
end implement map
