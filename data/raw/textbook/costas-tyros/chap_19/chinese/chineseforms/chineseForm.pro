/*****************************************************************************

                         Utah State University

******************************************************************************/

implement chineseForm
    inherits formWindow
    open core, vpiDomains

constants
    className = "chineseforms/chineseForm".
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
    onShow : window::showListener.
clauses
    onShow(_Source, _Data) :-
        editorControl_ctl:setFontDialog(), !.
      onShow(_Source, _Data).
      
predicates
    onPinyinClick : button::clickResponder.
clauses
    onPinyinClick(_Source) = button::defaultAction :-
        Txt= editorControl_ctl:getEntireText(),
        ideograms::ideograms(Txt, Ans),
        editorControl_ctl:pasteStr(Ans).

% This code is maintained automatically, do not update it manually. 13:09:06-9.8.2007
facts
    editorControl_ctl : editorcontrol.
    pinyin_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("chineseForm"),
        setRect(rct(50,40,290,192)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        addShowListener(onShow),
        editorControl_ctl := editorcontrol::new(This),
        editorControl_ctl:setPosition(8, 6),
        editorControl_ctl:setSize(224, 106),
        pinyin_ctl := button::new(This),
        pinyin_ctl:setText("Pinyin2Ideogram"),
        pinyin_ctl:setPosition(4, 128),
        pinyin_ctl:setSize(92, 12),
        pinyin_ctl:setClickResponder(onPinyinClick).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement chineseForm
