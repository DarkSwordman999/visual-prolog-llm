/*****************************************************************************

                         Utah State University

******************************************************************************/

implement greetings
    inherits formWindow
    open core, vpiDomains

constants
    className = "greetings/greetings".
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
    onHiClick : button::clickResponder.
clauses
    onHiClick(_Source) = button::defaultAction :-
         W= custom_ctl:getVPIWindow(), 
         X= convert(integer,  math::random(100)),
         Y= convert(integer, math::random(100)),
         vpi::drawText(W, X , Y, "Hello!").

% This code is maintained automatically, do not update it manually. 00:30:30-1.8.2007
facts
    cancel_ctl : button.
    help_ctl : button.
    custom_ctl : custom.
    hi_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("greetings"),
        setRect(rct(50,40,290,160)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(128, 102),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(184, 102),
        help_ctl:setAnchors([control::right,control::bottom]),
        custom_ctl := custom::new(This),
        custom_ctl:setPosition(8, 8),
        custom_ctl:setSize(192, 80),
        hi_ctl := button::new(This),
        hi_ctl:setText("Hi"),
        hi_ctl:setPosition(52, 102),
        hi_ctl:setClickResponder(onHiClick).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement greetings
