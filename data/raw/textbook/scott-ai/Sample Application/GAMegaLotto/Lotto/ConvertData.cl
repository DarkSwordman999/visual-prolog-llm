/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/
class convertData
    open core, lottoDomains

predicates

    getData : ().                      % We want this Predicate visible outside of convertData
    getHistoryData : (number*, number*, number*, number*, number*, number*, number*, number*) determ (o,o,o,o,o,o,o,o).
    getHistoryDataAgain : ().
     
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

end class convertData