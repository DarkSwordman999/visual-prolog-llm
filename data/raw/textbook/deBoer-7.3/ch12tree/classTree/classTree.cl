/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class classTree
    open core

domains
    stringlist = string*.
    treetype = tree(string, treetype, treetype) ; empty.


predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    add_from_list : (stringlist) procedure (i).
    treeinsert : (string NewItem, treetype OldTree, treetype Newtree) procedure (i,i,o).
    traverse : (string TraverseOrder) procedure (i).
    preOrderTraverse : (treetype Tree) procedure (i).
    inOrderTraverse : ( treetype Tree) procedure (i).
    postOrdertraverse : (treetype Tree) procedure (i).

end class classTree