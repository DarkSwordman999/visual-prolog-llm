/*****************************************************************************

                         Utah State University

******************************************************************************/

implement tabs
    inherits formWindow
    open core, vpiDomains

constants
    className = "forms/tabs".
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
        generatedInitialize(),
        %
        Page1 = tabPage::new(),
        Tab1 = helloTab::new(Page1:getContainerControl()),
        Page1:setText(Tab1:getText()),
        tabControl_ctl:addPage(Page1),
        Page2 = tabPage::new(),
        Tab2 = fibTab::new(Page2:getContainerControl()),
        Page2:setText(Tab2:getText()),
        tabControl_ctl:addPage(Page2),
        succeed.
   
   
% This code is maintained automatically, do not update it manually. 17:03:03-4.8.2007
facts
    tabControl_ctl : tabcontrol.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("tabs"),
        setRect(rct(50,40,250,140)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        tabControl_ctl := tabcontrol::new(This),
        tabControl_ctl:setPosition(4, 4),
        tabControl_ctl:setSize(192, 92).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement tabs
