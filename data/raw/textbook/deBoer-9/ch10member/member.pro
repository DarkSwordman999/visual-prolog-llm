/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement member

clauses

member(Number, [Number | _ ]).
member(Number, [ _ | Tail]) :-
    member(Number,Tail).

end implement member
