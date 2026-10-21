/*****************************************************************************

                         Utah State University

******************************************************************************/

implement query
    inherits formWindow
    open core, vpiDomains

constants
    className = "tabPackage/query".
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
        Page1= tabPage::new(),
        _Pronunciation  = pronunciationTab::new(Page1:getContainerControl()), 
        Page1:setText("Pronunciation"),
        tabControl_ctl:addPage(Page1),
        Page2= tabPage::new(),
        _Declension  = declensionTab::new(Page2:getContainerControl()), 
        Page2:setText("Declension"),
        tabControl_ctl:addPage(Page2),
         Page3= tabPage::new(),
        _Verb  = verbTab::new(Page3:getContainerControl()), 
        Page3:setText("Verbs"),
        tabControl_ctl:addPage(Page3).

% This code is maintained automatically, do not update it manually. 20:06:35-5.8.2007
facts
    tabControl_ctl : tabcontrol.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("query"),
        setRect(rct(50,40,350,240)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        tabControl_ctl := tabcontrol::new(This),
        tabControl_ctl:setPosition(0, 2),
        tabControl_ctl:setSize(300, 204).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement query
