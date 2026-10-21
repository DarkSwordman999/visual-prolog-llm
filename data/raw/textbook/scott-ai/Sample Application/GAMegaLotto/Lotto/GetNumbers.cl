/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/
class getNumbers
    open core, lottoDomains, convertData

predicates
    history : (string*)  procedure ([o, o, o, o, o]).
    saveHistory : ().
    randomAgain : (string, string) procedure (o, o).
    displayHelp : (string) procedure (o).
        
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

end class getNumbers