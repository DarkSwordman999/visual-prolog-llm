/*****************************************************************************

                         Utah State University

******************************************************************************/

implement verbs
    open core, string

constants
    className = "verbs/verbs".
    classVersion = "".

domains
   conj= prima; secunda; tertia; quarta; mixta.

class facts - verb_base
    verb:(string, string, string, string*)  nondeterm.
    presRoot:(string, string, conj) nondeterm.
   
   verb_state:(string, string).
    
class predicates
   dic_entry:(string) nondeterm (o).
   pres_ind:(string, string*) procedure (i, o).
     pres_subj:(string, string*) procedure (i, o).
     imperf_ind:(string, string*) procedure (i, o).
     imperf_subj:(string, string*) procedure (i, o).
clauses
    classInfo(className, classVersion).
    
    verb_state("pres", "ind").
    verb_state("pres", "subj").
    verb_state("imperf", "ind").
    verb_state("imperf", "subj").
        
    pres_root_conj(V, "pres", "ind", L) :- !, pres_ind(V, L). 
    pres_root_conj(V, "imperf", "ind", L) :- !,   imperf_ind(V, L). 
    pres_root_conj(V, "pres", "subj", L) :- !, pres_subj(V, L). 
    pres_root_conj(V, "imperf", "subj", L) :- !, imperf_subj(V, L). 
    pres_root_conj(_, _, _, []).
        
    pres_ind(V, L) :- verb(V, "ind", "pres", L), !.
    pres_ind(V, L) :- presRoot(V, Rt, prima), !,
       A1= concat(Rt, "O"), A2= concat(Rt, "AS"), A3= concat(Rt, "AT"),
       A4= concat(Rt, "AMUS"), A5= concat(Rt, "ATIS"), A6= concat(Rt, "ANT"),
       L= [A1, A2, A3, A4, A5, A6].
    pres_ind(V, L) :- presRoot(V, Rt, secunda), !,
       A1= concat(Rt, "O"), A2= concat(Rt, "S"), A3= concat(Rt, "T"),
       A4= concat(Rt, "MUS"), A5= concat(Rt, "TIS"),  A6= concat(Rt, "NT"),
       L= [A1, A2, A3, A4, A5, A6].
    pres_ind(V, L) :- presRoot(V, Rt, tertia), !,
       A1= concat(Rt, "O"), A2= concat(Rt, "IS"), A3= concat(Rt, "IT"),
       A4= concat(Rt, "IMUS"), A5= concat(Rt, "ITIS"), A6= concat(Rt, "UNT"),
       L= [A1, A2, A3, A4, A5, A6].
    pres_ind(V, L) :- presRoot(V, Rt, quarta), !,
       A1= concat(Rt, "IO"), A2= concat(Rt, "IS"), A3= concat(Rt, "IT"),
       A4= concat(Rt, "IMUS"), A5= concat(Rt, "ITIS"), A6= concat(Rt, "IUNT"),
       L= [A1, A2, A3, A4, A5, A6].
    pres_ind(V, L) :- presRoot(V, Rt, mixta), !,
       A1= concat(Rt, "IO"), A2= concat(Rt, "IS"), A3= concat(Rt, "IT"),
       A4= concat(Rt, "IMUS"), A5= concat(Rt, "ITIS"), A6= concat(Rt, "IUNT"),
       L= [A1, A2, A3, A4, A5, A6].
     pres_ind(_V, []).
   
    pres_subj(V, L) :- verb(V, "subj", "pres", L), !.
    pres_subj(V, L) :- presRoot(V, Rt, prima), !,
       A1= concat(Rt, "EM"), A2= concat(Rt, "ES"), A3= concat(Rt, "ET"),
       A4= concat(Rt, "EMUS"), A5= concat(Rt, "ETIS"), A6= concat(Rt, "ENT"),
       L= [A1, A2, A3, A4, A5, A6].
    pres_subj(V, L) :- presRoot(V, Rt, secunda), !,
       A1= concat(Rt, "AM"), A2= concat(Rt, "AS"), A3= concat(Rt, "AT"),
       A4= concat(Rt, "AMUS"), A5= concat(Rt, "ATIS"),  A6= concat(Rt, "ANT"),
       L= [A1, A2, A3, A4, A5, A6].
    pres_subj(V, L) :- presRoot(V, Rt, tertia), !,
       A1= concat(Rt, "AM"), A2= concat(Rt, "AS"), A3= concat(Rt, "AT"),
       A4= concat(Rt, "AMUS"), A5= concat(Rt, "ATIS"), A6= concat(Rt, "ANT"),
       L= [A1, A2, A3, A4, A5, A6].
    pres_subj(V, L) :- presRoot(V, Rt, quarta), !,
       A1= concat(Rt, "IAM"), A2= concat(Rt, "IAS"), A3= concat(Rt, "IAT"),
       A4= concat(Rt, "IAMUS"), A5= concat(Rt, "IATIS"), A6= concat(Rt, "IANT"),
       L= [A1, A2, A3, A4, A5, A6].
    pres_subj(V, L) :- presRoot(V, Rt, mixta), !,
       A1= concat(Rt, "IAM"), A2= concat(Rt, "IAS"), A3= concat(Rt, "IAT"),
       A4= concat(Rt, "IAMUS"), A5= concat(Rt, "IATIS"), A6= concat(Rt, "IANT"),
       L= [A1, A2, A3, A4, A5, A6].
     pres_subj(_V, []).
   
     
    imperf_ind(V, L) :- verb(V, "ind", "imperf", L), !.
    imperf_ind(V, L) :- presRoot(V, Rt, prima), !,
       A1= concat(Rt, "ABAM"), A2= concat(Rt, "ABAS"), A3= concat(Rt, "ABAT"),
       A4= concat(Rt, "ABAMUS"), A5= concat(Rt, "ABATIS"), A6= concat(Rt, "ABANT"),
       L= [A1, A2, A3, A4, A5, A6].
    imperf_ind(V, L) :- presRoot(V, Rt, secunda), !,
       A1= concat(Rt, "BAM"), A2= concat(Rt, "BAS"), A3= concat(Rt, "BAT"),
       A4= concat(Rt, "BAMUS"), A5= concat(Rt, "BATIS"),  A6= concat(Rt, "BANT"),
       L= [A1, A2, A3, A4, A5, A6].
    imperf_ind(V, L) :- presRoot(V, Rt, tertia), !,
       A1= concat(Rt, "EBAM"), A2= concat(Rt, "EBAS"), A3= concat(Rt, "EBAT"),
       A4= concat(Rt, "EBAMUS"), A5= concat(Rt, "EBATIS"), A6= concat(Rt, "EBANT"),
       L= [A1, A2, A3, A4, A5, A6].
    imperf_ind(V, L) :- presRoot(V, Rt, quarta), !,
       A1= concat(Rt, "IEBAM"), A2= concat(Rt, "IEBAS"), A3= concat(Rt, "IEBAT"),
       A4= concat(Rt, "IEBAMUS"), A5= concat(Rt, "IEBATIS"), A6= concat(Rt, "IEBANT"),
       L= [A1, A2, A3, A4, A5, A6].
    imperf_ind(V, L) :- presRoot(V, Rt, mixta), !,
       A1= concat(Rt, "IEBAM"), A2= concat(Rt, "IEBAS"), A3= concat(Rt, "IEBAT"),
       A4= concat(Rt, "IEBAMUS"), A5= concat(Rt, "IEBATIS"), A6= concat(Rt, "IEBANT"),
       L= [A1, A2, A3, A4, A5, A6].
     imperf_ind(_V, []).
     
    imperf_subj(V, L) :- verb(V, "subj", "imperf", L), !.
    imperf_subj(V, L) :- presRoot(V, Rt, prima), !,
       A1= concat(Rt, "AREM"), A2= concat(Rt, "ARES"), A3= concat(Rt, "ARET"),
       A4= concat(Rt, "AREMUS"), A5= concat(Rt, "ARETIS"), A6= concat(Rt, "ARENT"),
       L= [A1, A2, A3, A4, A5, A6].
    imperf_subj(V, L) :- presRoot(V, Rt, secunda), !,
       A1= concat(Rt, "REM"), A2= concat(Rt, "RES"), A3= concat(Rt, "RET"),
       A4= concat(Rt, "REMUS"), A5= concat(Rt, "RETIS"),  A6= concat(Rt, "RENT"),
       L= [A1, A2, A3, A4, A5, A6].
    imperf_subj(V, L) :- presRoot(V, Rt, tertia), !,
       A1= concat(Rt, "EREM"), A2= concat(Rt, "ERES"), A3= concat(Rt, "ERET"),
       A4= concat(Rt, "EREMUS"), A5= concat(Rt, "ERETIS"), A6= concat(Rt, "ERENT"),
       L= [A1, A2, A3, A4, A5, A6].
    imperf_subj(V, L) :- presRoot(V, Rt, quarta), !,
       A1= concat(Rt, "IREM"), A2= concat(Rt, "IRES"), A3= concat(Rt, "IRET"),
       A4= concat(Rt, "IREMUS"), A5= concat(Rt, "IRETIS"), A6= concat(Rt, "IRENT"),
       L= [A1, A2, A3, A4, A5, A6].
    imperf_subj(V, L) :- presRoot(V, Rt, mixta), !,
       A1= concat(Rt, "EREM"), A2= concat(Rt, "ERES"), A3= concat(Rt, "ERET"),
       A4= concat(Rt, "EREMUS"), A5= concat(Rt, "ERETIS"), A6= concat(Rt, "ERENT"),
       L= [A1, A2, A3, A4, A5, A6].
     imperf_subj(_V, []).
     
     
    dic_entry(V) :- verb(V, "ind", "pres", _).
    dic_entry(V) :- presRoot(V, _, _).
       
    verb("SUM", "ind", "pres", ["SUM", "ES", "EST", "SUMUS", "ESTIS", "SUNT"]).
    verb("SUM", "ind", "imperf", ["ERAM", "ERAS", "ERAT", "ERAMUS", "ERATIS", "ERANT"]).
    verb("VOLO", "ind", "pres", ["VOLO", "VIS", "VULT", "VOLUMUS", "VULTIS", "VOLUNT"]).
    verb("VOLO", "ind", "imperf", ["VOLEBAM", "VOLEBAS", "VOLEBAT", "VOLEBAMUS", "VOLEBATIS", "VOLEBANT"]).
    verb("SUM", "subj", "pres", ["SIM", "SIS", "SIT", "SIMUS", "SITIS", "SINT"]).
    verb("SUM", "subj", "imperf", ["ESSEM", "ESSES", "ESSET", "ESSEMUS", "ESSETIS", "ESSENT"]).
    verb("VOLO", "subj", "pres", ["VELIM", "VELIS", "VELIT", "VELIMUS", "VELITIS", "VELINT"]).
    verb("VOLO", "subj", "imperf", ["VELLEM", "VELLES", "VELLET", "VELLEMUS", "VELLETIS", "VELLENT"]).
    presRoot("AMO", "AM", prima).
    presRoot("VIDEO", "VIDE", secunda).
    
    read(File) :- 
        retractFactDb(verb_base),
        file::consult(File, verb_base).

   allVerbs(L) :-  L= [Q || dic_entry(Q)].
   
   next_verb_state() :- retract(verb_state(_,_)), !.
   next_verb_state().
   
   get_verb_state(X,  Y) :- verb_state(X, Y), !.
   get_verb_state("none", "none").
   
end implement verbs
