/*****************************************************************************

                         Utah State University

******************************************************************************/

implement txtWin
    inherits formWindow
    open core, vpiDomains

constants
    className = "txtWin/txtWin".
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
    onMenuItem : window::menuItemListener.
clauses
    onMenuItem(_Source, M) :- 
        Item= resourceIdentifiers::id_help_contents,
        M= Item, !, 
        stdio::write("Hello\n").
   onMenuItem(_Source,  _M) .
% This code is maintained automatically, do not update it manually. 19:39:51-31.8.2010
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("txtWin"),
        setRect(rct(50,40,290,160)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(resMenu(resourceIdentifiers::id_TaskMenu)),
        addMenuItemListener(onMenuItem),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(72, 102),
        ok_ctl:setSize(48, 12),
        ok_ctl:defaultHeight := false(),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(128, 102),
        cancel_ctl:setSize(48, 12),
        cancel_ctl:defaultHeight := false(),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(184, 102),
        help_ctl:setSize(48, 12),
        help_ctl:defaultHeight := false(),
        help_ctl:setAnchors([control::right,control::bottom]).
% end of automatic code
end implement txtWin
