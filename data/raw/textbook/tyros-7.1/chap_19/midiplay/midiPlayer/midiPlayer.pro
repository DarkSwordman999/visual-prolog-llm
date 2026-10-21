/*****************************************************************************

                         Utah State University

******************************************************************************/

implement midiPlayer
    inherits formWindow
    open core, vpiDomains

constants
    className = "midiPlayer/midiPlayer".
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
        SongList=  listSongs_ctl  : tryGetVpiWindow(),
        L= ["Wagner", "Lima", "India", "Beethoven"],
        vpi::lboxAdd(SongList, L),
        vpi::lboxSetSel(SongList, 0, 1), !.
    onShow(_Source, _Data).

class predicates
    scholia:(string) procedure (i).

clauses
   scholia("Wagner") :-  !,
       stdio::write("This song from the opera Siegfried is Wagner at his best.\n"),
       stdio::nl.
  scholia("Lima") :- !,
      stdio::write("Maestro Lima has used a computer to compose this piece of music.\n"),
       stdio::nl.
  scholia("India") :- !,
      _ = multiMedia_native::sndPlaySound("india.wav", 
                                              multiMedia_native::snd_ASync),
      stdio::write("Maestro José Asunción Flores composed India, "),
      stdio::write("a haunting song about a  Guarani Indian girl.\n"), 
      stdio::write("The singer is the Maestro Idalmo Lara. \n\n"),
      stdio::write("India, pretty mestiza of goddess and panther,\n"),
      stdio::write("naked girl that lives in Guaira.\n"),
       stdio::write("A wild dance has bent her hips into the shape\n"),
       stdio::write("of the blue curves of the Parana river.\n"),
        stdio::write("On her temples shine the pride of feathers,\n"),
        stdio::write("her language is wild a honeycomb.\n"),
        stdio::write("A necklace from teeth of tigers and pumas\n"),
        stdio::write("is a jewel for the muse of Ybytyruz.\n"),
       stdio::nl.
  scholia("Beethoven") :- !,
      stdio::write("Für Elise is one of the most popular tunes written\n"),
      stdio::write("by Ludwig van Beethoven.\n"),
       stdio::nl.
  scholia(_).
  
predicates
    onPlayClick : button::clickResponder.
clauses
   onPlayClick(_Source) = button::defaultAction :-
       Null = null, Len = 300,
       _= multiMedia_native::mciSendString(
                string::createCopy("Close mid"),
                string::create(300, " "),  Len, Null),
       Buffer =string::create(300, " "),
       File= listSongs_ctl:getText(),
       C= "open %s.mid type sequencer alias mid",
       Command= string::format(C, File),
       _= multiMedia_native::mciSendString(
                               Command, Buffer, Len, Null),
       _= multiMedia_native::mciSendString(
                       "Play mid from 0",
                      Buffer, Len, Null),
     scholia(File),
      _= vpi::processEvents().
      
predicates
    onStopClick : button::clickResponder.
clauses
    onStopClick(_Source) = button::defaultAction :-
           Null= null,
           _Z= multiMedia_native::mciSendString(string::createCopy("Close mid"), 
                                           string::create(300, " "), 300, Null).

% This code is maintained automatically, do not update it manually. 00:51:11-14.8.2007
facts
    listSongs_ctl : listEdit.
    play_ctl : button.
    stop_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("MS Sans Serif", 8)),
        setText("midiPlayer"),
        setRect(rct(50,40,246,150)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        addShowListener(onShow),
        listSongs_ctl := listEdit::new(This),
        listSongs_ctl:setText(""),
        listSongs_ctl:setPosition(24, 28),
        listSongs_ctl:setWidth(96),
        play_ctl := button::new(This),
        play_ctl:setText("Play"),
        play_ctl:setPosition(136, 28),
        play_ctl:setClickResponder(onPlayClick),
        stop_ctl := button::new(This),
        stop_ctl:setText("Stop"),
        stop_ctl:setPosition(136, 50),
        stop_ctl:setClickResponder(onStopClick).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement midiPlayer
