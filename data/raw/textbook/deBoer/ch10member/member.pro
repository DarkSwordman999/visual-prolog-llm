/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement member
    open core

constants
    className = "member".
    classVersion = "".

clauses
    classInfo(className, classVersion).

member(Number, [Number | _ ]).
member(Number, [ _ | Tail]) :-
    member(Number,Tail).

end implement member
