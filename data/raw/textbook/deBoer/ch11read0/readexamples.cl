/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class readexamples
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
    readSomeTerms : (inputStream Ints, inputStream Strings, inputstream Functors) procedure (i,i,i).

end class readexamples