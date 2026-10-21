/*****************************************************************************

                         Utah State University

******************************************************************************/
class midiPlayer : midiPlayer
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> midiPlayer MidiPlayer.

constructors
    new : (window Parent).

end class midiPlayer