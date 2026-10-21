/*****************************************************************************

                         Utah State University

******************************************************************************/

implement verbTab
    inherits userControlSupport
    open core, vpiDomains

constants
    className = "tabPackage/verbTab".
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
            VerbList= listVerb_ctl : tryGetVpiWindow(), 
            verbs::allVerbs(L),
            vpi::lboxAdd(VerbList, L),
            vpi::lboxSetSel(VerbList, 0, 1), !,
            verbs:: get_verb_state(Tense,  Mood),
            mood_ctl:setText(Mood),
            tense_ctl:setText(Tense).
     onShow(_Source, _Data).


predicates
    onCheckClick : button::clickResponder.
clauses
    onCheckClick(_Source) = button::defaultAction :-
          VerbList= listVerb_ctl : tryGetVpiWindow(),
          C= vpi::lboxCountAll(VerbList),
          C= 0,  verbs::next_verb_state(),
          verbs::get_verb_state(Tense, Mood),
           mood_ctl:setText(Mood),
            tense_ctl:setText(Tense),
            VerbList= listVerb_ctl : tryGetVpiWindow(), 
            verbs::allVerbs(L),
            vpi::lboxAdd(VerbList, L),
           fail().
    onCheckClick(_Source) = button::defaultAction :-
        Txt= editorControl_ctl:getEntireText(),
        Verb= listVerb_ctl:getText(),
        VerbList= listVerb_ctl : tryGetVpiWindow(),
        IV= vpi::lboxGetSelIndex(VerbList), !,
        Mood= mood_ctl:getText(),
        Tense= tense_ctl:getText(),
         verbs::pres_root_conj(Verb, Tense, Mood, L),
         if  template::check_it(Txt,  L, Ans) then
             editorControl_ctl:pasteStr(" "),
             vpi::lboxDelete (VerbList, IV) ,
             C= vpi::lboxCountAll(VerbList),
             if  C= 0 then
                       verbs::next_verb_state(),
                       verbs::get_verb_state(NewTense,  NewMood),
                       mood_ctl:setText(NewMood),
                       tense_ctl:setText(NewTense),
                       verbs::allVerbs(NewList),
                       vpi::lboxAdd(VerbList, NewList)
              else
                  succeed()
              end if,
              vpi::lboxSetSel(VerbList, 0, 1)
          else
             template::check_present(Txt,  L, Ans),
             editorControl_ctl:pasteStr(Ans)
          end if.
     onCheckClick(_Source)  = button::defaultAction.
% This code is maintained automatically, do not update it manually. 19:04:14-7.8.2007
facts
    listVerb_ctl : listEdit.
    check_ctl : button.
    editorControl_ctl : editorcontrol.
    mood_ctl : editControl.
    tense_ctl : editControl.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("verbTab"),
        This:setSize(300, 200),
        addShowListener(onShow),
        listVerb_ctl := listEdit::new(This),
        listVerb_ctl:setText(""),
        listVerb_ctl:setPosition(8, 10),
        listVerb_ctl:setWidth(80),
        listVerb_ctl:setMaxDropDownRows(10),
        check_ctl := button::new(This),
        check_ctl:setText("Check"),
        check_ctl:setPosition(244, 10),
        check_ctl:setSize(50, 12),
        check_ctl:setClickResponder(onCheckClick),
        editorControl_ctl := editorcontrol::new(This),
        editorControl_ctl:setPosition(12, 40),
        editorControl_ctl:setSize(275, 140),
        mood_ctl := editControl::new(This),
        mood_ctl:setText(""),
        mood_ctl:setPosition(100, 10),
        mood_ctl:setReadOnly(),
        tense_ctl := editControl::new(This),
        tense_ctl:setText(""),
        tense_ctl:setPosition(160, 10),
        tense_ctl:setReadOnly().
% end of automatic code
end implement verbTab
