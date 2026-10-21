/*****************************************************************************

                         Utah State University

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
    onProvoClick(S) = button::defaultAction :-
         Parent= S:getParent(),
        P= Parent:getVPIWindow(),
        draw::drawThem(P, "Provo").

% This code is maintained automatically, do not update it manually. 01:21:12-3.8.2007
facts
    logan_ctl : button.
    saltlake_ctl : button.
    provo_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("map"),
        setRect(rct(50,40,290,160)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        logan_ctl := button::new(This),
        logan_ctl:setText("Logan"),
        logan_ctl:setPosition(8, 104),
        logan_ctl:setClickResponder(onLoganClick),
        saltlake_ctl := button::new(This),
        saltlake_ctl:setText("SaltLake"),
        saltlake_ctl:setPosition(68, 104),
        saltlake_ctl:setClickResponder(onSaltlakeClick),
        provo_ctl := button::new(This),
        provo_ctl:setText("Provo"),
        provo_ctl:setPosition(128, 104),
        provo_ctl:setClickResponder(onProvoClick).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement map
