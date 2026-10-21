/*****************************************************************************

                         Utah State University

******************************************************************************/

implement declensionTab
    inherits userControlSupport
    open core, vpiDomains

constants
    className = "tabPackage/declensionTab".
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
    onShow : window::showListener.
clauses
     onShow(_Source, _Data) :-
            cases::get_number_state(Number),
            num_ctl:setText(Number),
            WordList= word_list_ctl : tryGetVpiWindow(), 
           cases::allWords(Ws),
            vpi::lboxAdd(WordList,Ws),
            vpi::lboxSetSel(WordList,  0, 1), !.
     onShow(_Source, _Data).

predicates
    onCheckClick : button::clickResponder.
clauses
    onCheckClick(_Source) = button::defaultAction :-
        Txt= editorControl_ctl:getEntireText(),
        Num= num_ctl:getText(),
        W= word_list_ctl:getText(),
        WordList=word_list_ctl: tryGetVpiWindow(),
        IV= vpi::lboxGetSelIndex( WordList), !,
        cases::declension(W, Num,  L),
        if  template::check_it(Txt,  L, Ans) then
             editorControl_ctl:pasteStr(" "),
             vpi::lboxDelete (WordList, IV) ,
             C= vpi::lboxCountAll(WordList),
             if C=0 then
                 cases::next_number_state(),
                 cases::get_number_state(NewNum),
                 num_ctl:setText(NewNum),
                 cases::allWords(NewWs),
                 vpi::lboxAdd(WordList, NewWs)
              else
                 succeed()
              end if,
              vpi::lboxSetSel(WordList,  0, 1)
           else
               template::check_present(Txt,  L, Ans),
               editorControl_ctl:pasteStr(Ans)
           end if.
      onCheckClick(_Source) = button::defaultAction.

% This code is maintained automatically, do not update it manually. 19:53:32-7.8.2007
facts
    check_ctl : button.
    editorControl_ctl : editorcontrol.
    word_list_ctl : listEdit.
    num_ctl : editControl.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("declensionTab"),
        This:setSize(300, 200),
        addShowListener(onShow),
        check_ctl := button::new(This),
        check_ctl:setText("Check"),
        check_ctl:setPosition(230, 10),
        check_ctl:setSize(50, 12),
        check_ctl:setClickResponder(onCheckClick),
        editorControl_ctl := editorcontrol::new(This),
        editorControl_ctl:setPosition(12, 40),
        editorControl_ctl:setSize(275, 140),
        word_list_ctl := listEdit::new(This),
        word_list_ctl:setText(""),
        word_list_ctl:setPosition(80, 10),
        word_list_ctl:setWidth(120),
        num_ctl := editControl::new(This),
        num_ctl:setText(""),
        num_ctl:setPosition(12, 10),
        num_ctl:setReadOnly().
% end of automatic code
end implement declensionTab
