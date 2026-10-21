implement midi
    open core
class predicates
   note:(string, unsigned8) procedure (i, o).
   duration:(string, unsigned8) procedure (i, o).
   tomidi:(string*, unsigned8*) procedure (i, o).   
   mSz:(integer, unsigned8, unsigned8, unsigned8, unsigned8) 
                                     procedure (i, o, o, o, o).
class facts
   nt:(string, unsigned8).
clauses
    classInfo("midi/midi", "1.0").

duration(X, Y) :- Y= toTerm(X),   Y < 128, !.
duration(_X, 24).

nt("C",  60).  nt("D",  62).  nt("E",  64).  nt("F",  65).  nt("G", 67).  
nt("A", 69).  nt("B", 71).  nt("C5", 72).  nt("D5", 74).  
nt("C#", 61).  nt("D#", 63). nt("F#", 66).
nt("G#", 68). nt("A#", 70). nt("Bb", 70). 

note(X, Y) :- nt(X, Y), !.
note(_, 69).

tomidi([N, D|Rs], [0,192, 24, 0,144,N1, 127,F1,128,N1,0|R] ) :- 
         /* guitar=24, violin=  40 voice= 52 */
         note(N, N1),   duration(D, F1), !, tomidi(Rs, R).
tomidi(_, []).

mSz(S, 0, 0, X3, X4) :-   I4= S  mod 256, X4= convert(unsigned8, I4),  
    S1= S div 256, I3=  S1 mod 256, X3= convert(unsigned8, I3).
    
generate(File, Music) :- tomidi(Music, L),
    Events= [0, 255, 89, 2, 0, 0, 0, 255, 81, 3, 7, 161,
                  32, 0, 255, 88, 4, 2, 2, 24, 8],
    NC= list::length(Events),  N1= list::length(L),
    Cnt= NC+ N1 + 4, mSz(Cnt, X1, X2, X3, X4),
     MainHeader= [ 77, 84, 104, 100, 0, 0, 0, 6, 0, 0, 0, 1, 0, 48,
                          77, 84, 114, 107, X1, X2, X3, X4],
    H=  list::append(MainHeader, Events, L, [0,255,47,0]),
    P= outputStream_file::create(File, stream::binary()),
   foreach X= list::getMember_nd (H) do
       P:write(X)
  end foreach,
  P:close(). 
end implement midi
