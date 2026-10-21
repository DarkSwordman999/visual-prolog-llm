/*****************************************************************************

                         Utah State University

******************************************************************************/

implement cases
    open core, string

constants
    className = "cases/cases".
    classVersion = "".

domains
   declens= prma; snda; trtum; trtium; trtii; qrta; qnta; nsnda; ntrtum; ntrtium.
   
class facts - noun_base
    wrd:(string, string,  string*)  nondeterm.
    decl:(string, string, declens) nondeterm.
    num_state:(string).
clauses
    classInfo(className, classVersion).

num_state("singular").
num_state("plural").

wrd("ROSA", "singular", ["ROSA", "ROSAE", "ROSAE", "ROSA", "ROSAM"]).
wrd("ROSA", "plural", ["ROSAE", "ROSARUM", "ROSIS", "ROSIS", "ROSAS"]).
wrd("PUER", "singular", ["PUER", "PUERI", "PUERO", "PUERO", "PUERUM"]).
wrd("PUER", "plural", ["PUERI", "PUERORUM", "PUERIS", "PUERIS", "PUEROS"]).
decl("DOMINUS", "DOMIN", snda).

declension(W, N, L) :- wrd(W, N, L), !.
declension(W, "singular", L) :- decl(W, Root, prma), !,
       N= W, G= concat(Root, "AE"), D= concat(Root, "AE"),
       Abl= concat(Root, "A"), Acc= concat(Root, "AM"),
       L= [N, G, D, Abl, Acc].
declension(W, "plural", L) :- decl(W, Root, prma), !,
       N= concat(Root, "AE"), G= concat(Root, "ARUM"), D= concat(Root, "IS"),
       Abl= concat(Root, "IS"), Acc= concat(Root, "AS"),
       L= [N, G, D, Abl, Acc].
declension(W, "singular", L) :- decl(W, Root, snda), !,
       N= W, G= concat(Root, "I"), D= concat(Root, "O"),
       Abl= concat(Root, "O"), Acc= concat(Root, "UM"),
       L= [N, G, D, Abl, Acc].
declension(W, "plural", L) :- decl(W, Root, snda), !,
       N= concat(Root, "I"), G= concat(Root, "ORUM"), D= concat(Root, "IS"),
       Abl= concat(Root, "IS"), Acc= concat(Root, "OS"),
       L= [N, G, D, Abl, Acc].
declension(W, "singular", L) :- decl(W, Root, nsnda), !,
       N= W, G= concat(Root, "I"), D= concat(Root, "O"),
       Abl= concat(Root, "O"), Acc= concat(Root, "UM"),
       L= [N, G, D, Abl, Acc].
declension(W, "plural", L) :- decl(W, Root, nsnda), !,
       N= concat(Root, "A"), G= concat(Root, "ORUM"), D= concat(Root, "IS"),
       Abl= concat(Root, "IS"), Acc= concat(Root, "A"),
       L= [N, G, D, Abl, Acc].
declension(W, "singular", L) :- decl(W, Root, trtium), !,
       N= W, G= concat(Root, "IS"), D= concat(Root, "I"),
       Abl= concat(Root, "E"), Acc= concat(Root, "EM"),
       L= [N, G, D, Abl, Acc].
declension(W, "plural", L) :- decl(W, Root, trtium), !,
       N= concat(Root, "ES"), G= concat(Root, "IUM"), D= concat(Root, "IBUS"),
       Abl= concat(Root, "IBUS"), Acc= concat(Root, "ES"),
       L= [N, G, D, Abl, Acc].
 declension(W, "singular", L) :- decl(W, Root, trtum), !,
       N= W, G= concat(Root, "IS"), D= concat(Root, "I"),
       Abl= concat(Root, "E"), Acc= concat(Root, "EM"),
       L= [N, G, D, Abl, Acc].
declension(W, "plural", L) :- decl(W, Root, trtum), !,
       N= concat(Root, "ES"), G= concat(Root, "UM"), D= concat(Root, "IBUS"),
       Abl= concat(Root, "IBUS"), Acc= concat(Root, "ES"),
       L= [N, G, D, Abl, Acc].
 declension(W, "singular", L) :- decl(W, Root, ntrtum), !,
       N= W, G= concat(Root, "IS"), D= concat(Root, "I"),
       Abl= concat(Root, "E"), Acc= W,
       L= [N, G, D, Abl, Acc].
declension(W, "plural", L) :- decl(W, Root, ntrtum), !,
       N= concat(Root, "A"), G= concat(Root, "UM"), D= concat(Root, "IBUS"),
       Abl= concat(Root, "IBUS"), Acc= concat(Root, "A"),
       L= [N, G, D, Abl, Acc].
  declension(W, "singular", L) :- decl(W, Root, ntrtium), !,
       N= W, G= concat(Root, "IS"), D= concat(Root, "I"),
       Abl= concat(Root, "I"), Acc= W,
       L= [N, G, D, Abl, Acc].
declension(W, "plural", L) :- decl(W, Root, ntrtium), !,
       N= concat(Root, "IA"), G= concat(Root, "IUM"), D= concat(Root, "IBUS"),
       Abl= concat(Root, "IBUS"), Acc= concat(Root, "IA"),
       L= [N, G, D, Abl, Acc].
 declension(W, "singular", L) :- decl(W, Root, trtii), !,
       N= W, G= concat(Root, "IS"), D= concat(Root, "I"),
       Abl= concat(Root, "I"), Acc= concat(Root, "EM"),
       L= [N, G, D, Abl, Acc].
declension(W, "plural", L) :- decl(W, Root, trtum), !,
       N= concat(Root, "ES"), G= concat(Root, "IUM"), D= concat(Root, "IBUS"),
       Abl= concat(Root, "IBUS"), Acc= concat(Root, "ES"),
       L= [N, G, D, Abl, Acc].
declension(_W, _, []).
       


 read(File) :- 
        retractFactDb(noun_base),
        file::consult(File, noun_base).
 
 allWords(Wrds) :- Wrds= [Q || wrd(Q, "singular", _); decl(Q, _, _)].     
 
  next_number_state() :- retract(num_state(_)), !.
  next_number_state().
   
   get_number_state(X) :- num_state(X), !.
   get_number_state("none").
     
end implement cases
