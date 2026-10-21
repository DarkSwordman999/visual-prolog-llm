/*****************************************************************************

                         Utah State University

******************************************************************************/

implement helloTab
    inherits userControlSupport
    open core, vpiDomains

constants
    className = "forms/helloTab".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    new(Parent):-
        new(),
        setContainer(Parent).

clauses
    new():-
        userControlSupport::new(),
        generatedInitialize().

predicates
    onYournameClick : button::clickResponder.
clauses
     onYournameClick(_Source) = button::defaultAction :-
         Name= edit_ctl:getText(),
         Ans= string::concat("Hello, ", Name, "!\n"),
         stdio::write(Ans).

% This code is maintained automatically, do not update it manually. 16:47:48-4.8.2007
facts
    edit_ctl : editControl.
    yourname_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("helloTab"),
        This:setSize(164, 38),
        edit_ctl := editControl::new(This),
        edit_ctl:setText(""),
        edit_ctl:setPosition(8, 10),
        edit_ctl:setWidth(72),
        yourname_ctl := button::new(This),
        yourname_ctl:setText("YourName"),
        yourname_ctl:setPosition(96, 10),
        yourname_ctl:setClickResponder(onYournameClick).
% end of automatic code
end implement helloTab
