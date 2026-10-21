/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class database
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
    storeNames : (unsigned Counter) -> unsigned Number procedure (i).
    fill : () procedure ().

end class database