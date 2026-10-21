/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement classTree
    open core

constants
    className = "classTree/classTree".
    classVersion = "".

class facts
    treefact : treetype := empty.

clauses
    classInfo(className, classVersion).

clauses
    add_from_list([]) :- !.
    add_from_list([NewItem | Tail]) :-
        treeinsert(NewItem, treefact, NewTree),
        treefact := Newtree,
        add_from_list(Tail).

    treeinsert(NewItem, empty, tree(NewItem, empty, empty)) :- !.
    treeinsert(NewItem, tree(Element, LEft, Right), tree(Element, Newleft, Right) ) :-
        NewItem <= Element, !,
        treeinsert(NewItem, Left, NewLeft).
    treeinsert(NewItem, tree(Element, LEft, Right), tree(Element, Left, Newright) ) :-
        treeinsert(NewItem, Right, NewRight).
    
    traverse("preorder") :-
        !, stdIO::nl, stdIO::write("the tree in PRE-order:"),
        preOrderTraverse(treefact), !, stdIO::nl.
    traverse("inorder") :-
        !, stdIO::nl, stdIO::write("the tree in IN-order:"),
        inOrderTraverse(treefact), !, stdIO::nl.
    traverse("postorder") :-
        !, stdIO::nl, stdIO::write("the tree in POST-order:"), 
        postOrderTraverse(treefact), !, stdIO::nl.
    traverse(_).
    
    preOrderTraverse(empty) :- !.
    preOrderTraverse(tree(Element, Left, Right)) :-
        stdIO::write(Element, " "),
        preOrderTraverse(Left),
        preOrderTraverse(Right).
    
    inOrderTraverse(empty) :- !.
    inOrderTraverse(tree(Element, Left, Right)) :-
        inOrderTraverse(Left),
        stdIO::write(Element, " "),
        inOrderTraverse(Right).

    postOrderTraverse(empty) :- !.
    postOrderTraverse(tree(Element, Left, Right)) :-
        postOrderTraverse(Left),
        postOrderTraverse(Right),
        stdIO::write(Element, " ").

end implement classTree
