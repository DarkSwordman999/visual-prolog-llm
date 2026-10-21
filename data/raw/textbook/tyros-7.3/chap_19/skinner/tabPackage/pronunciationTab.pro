/*****************************************************************************

                         Utah State University

******************************************************************************/

implement pronunciationTab
    inherits userControlSupport
    open core, vpiDomains, vpi
    % resolve playSound externally
      
constants
    className = "tabPackage/pronunciationTab".
    classVersion = "".

clauses
    classInfo(className, classVersion).

domains
    soundFlag = unsigned32.

class predicates
    playSound : (string Sound, 
        pointer HModule, 
        soundFlag SoundFlag) 
        -> booleanInt Success
        language apicall.

constants
   
    snd_async : soundFlag = 0x0001. 
         /* play asynchronously */
    
    snd_filename : soundFlag = 0x00020000. 
         /* name is file name */
    

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
         EditListHandle= listEdit_ctl : tryGetVpiWindow(), !,
         vpi::lboxAdd(EditListHandle, ["joubert", "newtoni",  "newtonii",  "newtoniii"]).
     onShow(_Source, _Data).

predicates
    onPlayClick : button::clickResponder.
clauses
    onPlayClick(_Source) = button::defaultAction :-
         File= listEdit_ctl:getText(),
         _ =  playSound(File, 
                          null, /*snd_nodefault*/ snd_async+snd_filename).

% This code is maintained automatically, do not update it manually. 11:20:34-15.8.2007
facts
    listEdit_ctl : listEdit.
    play_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("pronunciationTab"),
        This:setSize(300, 150),
        addShowListener(onShow),
        listEdit_ctl := listEdit::new(This),
        listEdit_ctl:setText(""),
        listEdit_ctl:setPosition(10, 10),
        listEdit_ctl:setWidth(100),
        listEdit_ctl:setMaxDropDownRows(10),
        play_ctl := button::new(This),
        play_ctl:setText("Play"),
        play_ctl:setPosition(120, 10),
        play_ctl:setSize(50, 12),
        play_ctl:defaultHeight := true(),
        play_ctl:setClickResponder(onPlayClick).
% end of automatic code
end implement pronunciationTab
