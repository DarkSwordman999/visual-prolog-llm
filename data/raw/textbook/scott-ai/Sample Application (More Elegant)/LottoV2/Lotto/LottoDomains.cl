/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/
class lottoDomains
    open core

domains % Global Domains to be used
    year = integer.                              % Lotto Data Imported: Year, Month, and Day
    month = integer.
    day = integer.
    number = integer.                         % Generic use of Numbers
    fiveNumbers = integer*.                % List of 5 Numbers
    strList = string*.                            % Generic List of String
    numData = num(number, number). % Functor to Compound a number with info
    file = input; output.                        % Used to deal with files
    
constants
    lottoReadFile = "Stats.txt".                     % The hard coded name of the download file
    localData = "LocalData.txt".                   % Used to Localize Data for the program
    lottoDB = "LottoData.txt".                      % Imported Lotto Data in format used by Prolog
    lottoCntData = "NumberCounts.txt".       % Information for program verificaion analysis
    lottoHistory = "HistoryData.txt".             % Extracted Historical Information.
    lottoHelpFile = "ImportInstructions.hlp".  % File to be used to provide User Help
    lottoNumbers = "LottoNumbers.txt".        % File use to Print History and Random Numbers

    % Number Balls 1-56 Numbers used for Regular Lotto Balls
    % Money Ball 1-46 Numbers used for the Mega Money Ball

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

end class lottoDomains