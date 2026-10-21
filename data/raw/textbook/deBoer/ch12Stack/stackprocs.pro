/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement stackprocs
    open core

constants
    className = "stackprocs".
    classVersion = "".

class facts
    stacklist : stringlist :=["ddd", "ccc", "bbb", "aaa"].

clauses
    classInfo(className, classVersion).

clauses
    push(Element) :-
        stacklist := [Element | stacklist].    %Put the new element in front of the stack

    peek(Element) :-
        [Element | _ ] = stacklist.     % take a look at the first Element but don’t change stacklist

    pop(Element) :-
        [Element | Tail] = stacklist,	% Get the first Element and ...
        stacklist := Tail. 			% ... take it off the stacklist
 
    dup() :-
        [Element | _] = stacklist,			% Get the first Element and ...
        stacklist := [Element | stacklist].		% ... put it in front of the stacklist
    
    swap() :-
        [Element1, Element2 | Tail] = stacklist,    % Take the first two elements and ...
        stacklist := [Element2, Element1 | Tail].    % ... change their places
    
    showstack() :-
        stdIO::write("The stack contains: "),
        stdIO::nl,
        stdIO::write(stacklist).
 
 

end implement stackprocs
