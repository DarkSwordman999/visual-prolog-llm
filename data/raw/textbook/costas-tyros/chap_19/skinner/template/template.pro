/*****************************************************************************

                         Utah State University

******************************************************************************/

implement template
    open core

constants
    className = "template/template".
    classVersion = "".

class facts
    points:integer := 0.
    
class predicates
   compare:(string*, string*, string, string)  procedure (i, i, i, o).
   checkAnswer:(string, string, string) procedure (i, i, o).
clauses
    classInfo(className, classVersion).
    
checkAnswer(X, Y, Ans) :- string::equalIgnoreCase(X, Y), !, Ans= string::concat(X, "=", Y, "\n").
checkAnswer(X, Y, Ans) :- Ans= string::concat(X, "<>", Y, "\n"), points := points+1, stdio::write("Points= ", points), stdio::nl.

compare([""|R], L, Partial, Ans) :-  !, compare(R, L, Partial, Ans).
compare([X|Xs], [Y|Ys], Partial, Ans) :- !,
   checkAnswer(X, Y, T),
    PP= string::concat(Partial, T),
    compare(Xs, Ys, PP, Ans).
compare([], [], Partial, Ans) :- !, Ans= Partial.
compare(_, _, Partial, Ans) :- Ans= string::concat(Partial, "\nsomething is wrong").
 
check_present(Txt, L, Ans) :- Ts=  string::split(Txt, " \n"),
              compare(Ts, L, "",  Ans).

check_it(Txt, L, Ans) :- points := 0,
    Ts=  string::split(Txt, " \n"),
    compare(Ts, L, "",  Ans),
    points=0.
end implement template
