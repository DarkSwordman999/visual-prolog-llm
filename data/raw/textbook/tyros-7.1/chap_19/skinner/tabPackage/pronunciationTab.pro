/*****************************************************************************

                         Utah State University

******************************************************************************/

implement pronunciationTab
    inherits userControlSupport
    open core, vpiDomains
    resolve playSound externally
      
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
    snd_sync : soundFlag = 0x0000.
         /* play synchronously (default) */
    snd_async : soundFlag = 0x0001. 
         /* play asynchronously */
    snd_nodefault : soundFlag = 0x0002. 
         /* silence (!default) if sound not found */
    snd_memory : soundFlag = 0x0004. 
         /* Sound points to a memory file */
    snd_loop : soundFlag = 0x0008. 
         /* loop the sound until next sndplaysound */
    snd_nostop : soundFlag = 0x0010. 
         /* don't stop any currently playing sound */
    snd_nowait : soundFlag = 0x00002000. 
         /* don't wait if the driver is busy */
    snd_alias : soundFlag = 0x00010000. 
         /* name is a registry alias */
    snd_alias_id : soundFlag = 0x00110000. 
         /* alias is a predefined id */
    snd_filename : soundFlag = 0x00020000. 
         /* name is file name */
    snd_resource : soundFlag = 0x00040004. 
         /* name is resource name or atom */
    snd_purge : soundFlag = 0x0040. 
         /* purge non-static events for task */
    snd_application : soundFlag = 0x0080. 
         /* look for application specific association */

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

% This code is maintained automatically, do not update it manually. 01:20:44-6.8.2007
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
        play_ctl:setClickResponder(onPlayClick).
% end of automatic code
end implement pronunciationTab
