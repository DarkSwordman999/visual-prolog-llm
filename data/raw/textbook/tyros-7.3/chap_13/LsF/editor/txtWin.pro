/*****************************************************************************

                         Utah State University

******************************************************************************/

implement txtWin
    inherits formWindow
    open core, vpiDomains

constants
    className = "editor/txtWin".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

class predicates
         tryGetFileContent:(
             string FileName,
             string InputStr,
             string UpdatedFileName) procedure (i, o, o).
clauses
   tryGetFileContent( "",  "", "LsF.txt") :- !.
   tryGetFileContent(FileName, InputStr, FileName) :-
                trap(file::existFile(FileName), _TraceId, fail), !, 
                InputStr= file::readString(FileName, _).
   tryGetFileContent(FileName, "", FileName).

   new(Parent):- formWindow::new(Parent),
        generatedInitialize(),
        PossibleName= "LsF.txt",
        tryGetFileContent(PossibleName, InputStr, _FileName), !,
        XX=string::concat("Here: ", InputStr),
        editorControl_ctl:pasteStr(XX).
        
predicates
    onHelpClick : button::clickResponder.
clauses
  onHelpClick(_Source) = button::defaultAction :-
      editorControl_ctl:getSelection(Start, End),
      Txt=editorControl_ctl:getText(Start, End),
      grammar::dic(Txt).

% This code is maintained automatically, do not update it manually. 18:17:53-2.8.2007
facts
    ok_ctl : button.
    cancel_ctl : button.
    help_ctl : button.
    editorControl_ctl : editorcontrol.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("txtWin"),
        setRect(rct(50,40,390,224)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        ok_ctl := button::newOk(This),
        ok_ctl:setText("&OK"),
        ok_ctl:setPosition(156, 164),
        ok_ctl:setAnchors([control::right,control::bottom]),
        cancel_ctl := button::newCancel(This),
        cancel_ctl:setText("Cancel"),
        cancel_ctl:setPosition(216, 164),
        cancel_ctl:setAnchors([control::right,control::bottom]),
        help_ctl := button::new(This),
        help_ctl:setText("&Help"),
        help_ctl:setPosition(276, 164),
        help_ctl:setAnchors([control::right,control::bottom]),
        help_ctl:setClickResponder(onHelpClick),
        editorControl_ctl := editorcontrol::new(This),
        editorControl_ctl:setPosition(12, 8),
        editorControl_ctl:setSize(308, 136).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement txtWin
