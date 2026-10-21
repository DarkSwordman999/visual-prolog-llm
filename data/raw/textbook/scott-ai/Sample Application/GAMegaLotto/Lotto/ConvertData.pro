/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/

implement convertData
    open core, lottoDomains, string, list, file
    

class facts - localFacts                  % Used for local static facts
  months: (integer, integer).
  
class facts - lottoData			          % Converted ‘Stats.txt’ Lotto Data   
   lotto : (year Year, month Month, day Day, number DateCP, fiveNumbers FN, number MoneyBall).

class facts - lottoNumberData		% Temporary data elements used to extract information
   numberCount : (numData X).		% Lotto Number and it’s count
   numberDate : (numData X).		% Lotto Number and it’s date
   moneyBallCount : (numData X).		% Money Ball Number and it’s count
   moneyBallDate : (numData X).		% Money Ball Number and it’s date
   nList : (number* X).			% A list of numbers
   ndList : (number* X).			% A list of dates
   mbList : (number* X).			% A list of Money Balls Numbers
   mbdList : (number* X).			% A list of Money Ball Number dates
   nnc : (number* X).			% A list of Numbers not counted
   mbnc : (number* X).			% A list of Money Ball Numbers not counted
   lcn : (numData* LCN).			% A list of Least Called Numbers
   mcn: (numData* MCN).			% A list of Most Called Numbers
   lcmb : (numData* A).			% A list Of Least Called Money Balls
   mcmb : (numData* C).			% A list of Most Called Money Balls
   ocn : (numData* OCN).			% A list of Oldest Called Numbers
   ocmb : (numData* A).			% A list of Oldest Called Money Balls

class facts - historyData                % Desired Historical Information
   numbersNeverCalled : (number* X).
   moneyBallsNeverCalled : (number* X).
   leastCalledNumbers : (number* LCN).
   mostCalledNumbers: (number* MCN).
   leastCalledMoneyBalls : (number* A).
   mostCalledMoneyBalls : (number* C).
   oldestCalledNumbers : (number* OCN).
   oldestCalledMoneyBalls : (number* A).

% Import Downloaded Data ----------------------
class predicates
    putData : () procedure.
    readData : (inputStream I) procedure (i).
    convStrList : (string Str, strList SL) procedure (i,o).
    getDate : (strList Str, year Y, month M, day D, number N) determ (i,o,o,o,o).
    getFiveNumbers : (strList SL, fiveNumbers N) determ (i,o).
    getMoneyBall : (strList SL, number N) determ (i,o).
    splitLine : (string Lotto,  year Year, month Month, day Day, number DateCP, 
                    fiveNumbers FiveNumbers, number MoneyBall) determ (i,o,o,o,o,o,o).

% Inititial Data ----------------------------------------
class predicates
  initializeHistoryData : ().
  initNumbers : (number X, number Y).
  initMoneyBalls : (number X, number Y).
  getAllNumbers : ().
  fiveNumbers : (fiveNumbers X) determ (i).
  moneyBall : (number X) determ (i).
  dates : (number X, fiveNumbers Y, number Z) determ (i,i,i).
  setNumberDate: (number X, number Y) procedure (i,i).
  setMoneyBallDate : (number X, number Y) procedure (i,i).

% Get Significant Historical Data (i.e. Never Called, Most Called, Least Called, Oldest, etc. --------------
class predicates
  getHistory : ().
  getLists : ().
  getNumbersNeverCalled : ().
  getMoneyBallsNeverCalled : ().
  getExtremeCalledNumbers : ().
  getExtremeCalledMoneyBalls : ().
  getOldestNumbers : ().
  getOldestMoneyBall : (). 
  getTop10Numbers : (number* L, number* M).
  getTop10MoneyBalls : (number* L, number* M).
  getTop10OldestNumbers : (number* L).
  getTop10OldestMoneyBalls : (number* L).

clauses
% To retrieve History Data from outside of the ConvertData Class
    getHistoryData(LCN, LCMB, MCN, MCMB, OCN, OCMB, NCN, NCMB) :-
         numbersNeverCalled(NCN),
         moneyBallsNeverCalled(NCMB),
         leastCalledNumbers(LCN),
         mostCalledNumbers(MCN),
         leastCalledMoneyBalls(LCMB),
         mostCalledMoneyBalls(MCMB),
         oldestCalledNumbers(OCN),
         oldestCalledMoneyBalls(OCMB), !.
         
 getHistoryDataAgain() :-
   consult("HistoryData.txt", historyData), !.

% Import Downloaded Data ---------------------------------

    getData() :-
        stdio::write("Reading Downloaded and Converted Data ........\n"),
        I = inputStream_file::openFile8(lottoReadFile),
        readData(I),
        %stdio::write("Download Data Acquired ........ \n"),
        initializeHistoryData,
        % stdio::write("All Numbers, Money Balls, and their Dates have been Initialized ........\n"), 
        getAllNumbers,
        % stdio::write("All Numbers and Money Balls have been Counted ........\n"),
        % stdio::write("All Dates Called have been Normalized ........\n"),
        getHistory,
        stdio::write("All Historical Information has been compiled ........\n"),
        putData,
        stdio::write("Data Exported as Consultable Files ........\n\n"), !.

   readData(I) :-
        not(I:endOfStream()),
        Lotto = I:readLine(),
        splitLine(Lotto, Year, Month, Day, DateCP, FiveNumbers, MoneyBall),
        assertz(lotto(Year, Month, Day, DateCP, FiveNumbers, MoneyBall)),
        readData(I),
        fail.
    readData(_):-!.

  putData() :-
       % file::save(localData, localFacts),
       % file::save(lottoCntData, lottoNumberData),
       file::save(lottoDB, lottoData),
       file::save(lottoHistory, historyData), !.

  splitLine(Lotto, Year, Month, Day, DateCP, FiveNumbers, MoneyBall) :-
    convStrList(Lotto,SL),
    getDate(SL, Year, Month, Day, DateCP),
    getFiveNumbers(SL, FiveNumbers),
    getMoneyBall(SL, MoneyBall), !.
    
    convStrList(Str, [H|T]) :-
      frontToken(Str,H,Str1), ! ,
      convStrList(Str1,T).
    convStrList(_,[]).
  
 % --------- M,D,Y,1,2,3,4,5,M ----------- 
    getDate([X,Y,Z,_,_,_,_,_,_], Year, Month, Day, DateCP) :-
      Month = toTerm(month, X),
      months(Month, Count),
      Day = toTerm(day, Y),
      Year = toTerm(year, Z),
      DateCP = ((Year-2000)*1000) + Count + Day,!.

    getFiveNumbers([_,_,_,A,B,C,D,E,_],FiveNumbers) :-
      Z = toTerm(number, A),
      Y = toTerm(number, B),
      X = toTerm(number, C),
      W = toTerm(number, D),
      V = toTerm(number, E),
      FiveNumbers = [Z,Y,X,W,V], !.
    
    getMoneyBall([_,_,_,_,_,_,_,_,X], MoneyBall) :-
      M = toTerm(number, X),
      MoneyBall = M.
   
  months(1, 0).
  months(2, 31).
  months(3, 60).
  months(4, 91).
  months(5, 121).
  months(6, 152).
  months(7, 182).
  months(8, 213).
  months(9, 244).
  months(10, 274).
  months(11, 305).
  months(12, 335).

% Inititial Data ----------------------------------------
clauses
  initializeHistoryData() :- 
      initNumbers(1,0),
      initMoneyBalls(1,0),!.
    
  initNumbers(57, _) :- !.
    % stdio::write("Number Counts have been Initialized ........\n"), !.
  initNumbers(X, Y) :-
    assertz(numberCount(num(X,Y))),
    assertz(numberDate(num(X,Y))),
    NewX = X + 1,
    initNumbers(NewX, Y).
    
  initMoneyBalls(47, _) :- !.
    % stdio::write("Money Ball Counts have been Initialized ........\n"), !.
  initMoneyBalls(X, Y) :-
    assertz(moneyBallCount(num(X,Y))),
    assertz(moneyBallDate(num(X,Y))),
    NewX = X + 1,
    initMoneyBalls(NewX, Y).

  getAllNumbers() :-
     lotto(_,_,_,W,X,Y), 
     fiveNumbers(X), 
     moneyBall(Y), 
     dates(W,X,Y),
     fail.
  getAllNumbers() :- !.

  fiveNumbers([A,B,C,D,E]) :- 
    retract(numberCount(num(A,OldC1))),
    NewC1 = OldC1 + 1, 
    assertz(numberCount(num(A,NewC1))),
    %-------------------------------------------
    retract(numberCount(num(B,OldC2))), 
    NewC2 = OldC2 + 1, 
    assertz(numberCount(num(B,NewC2))),
    %-------------------------------------------
    retract(numberCount(num(C,OldC3))),
    NewC3 = OldC3 + 1, 
    assertz(numberCount(num(C,NewC3))),
    %-------------------------------------------
    retract(numberCount(num(D,OldC4))),
    NewC4 = OldC4 + 1, 
    assertz(numberCount(num(D,NewC4))),
    %-------------------------------------------
    retract(numberCount(num(E,OldC5))),
    NewC5 = OldC5 + 1, 
    assertz(numberCount(num(E,NewC5))),!.
     
  moneyBall(A):-
    retract(moneyBallCount(num(A,X))), 
    Y = X+1, 
    assertz(moneyBallCount(num(A,Y))),!.

  dates(Date,[A,B,C,D,E],MB):-
    setNumberDate(Date, A),
    setNumberDate(Date, B),
    setNumberDate(Date, C),
    setNumberDate(Date, D),
    setNumberDate(Date, E),
    setMoneyBallDate(Date,MB).

  setNumberDate(DateI, X) :-
     numberDate(num(X, DateO)), 
     DateI > DateO,
     retract(numberDate(num(X, DateO))), 
     assertz(numberDate(num(X, DateI))),!.
  setNumberDate(_, _) :- !.

  setMoneyBallDate(DateI, X) :-
     moneyBallDate(num(X, DateO)), 
     DateI > DateO,
     retract(moneyBallDate(num(X, DateO))), 
     assertz(moneyBallDate(num(X, DateI))),!.
  setMoneyBallDate(_, _) :- !.

% Get Significant Historical Data (i.e. Most Called, Least Called, Oldest, etc. --------------
clauses
   getHistory() :- 
      getLists,
      getNumbersNeverCalled,
      getMoneyBallsNeverCalled,
      getExtremeCalledNumbers,
      getExtremeCalledMoneyBalls,
      getOldestNumbers,
      getOldestMoneyBall, !. 

  getLists():-
      findall(W, numberCount(num(_,W)), List1),
      findall(X, numberDate(num(_,X)), List2),
      findall(Y, moneyBallCount(num(_,Y)), List3),
      findall(Z, moneyBallDate(num(_,Z)), List4),
      assertz(nList(List1)),
      assertz(ndList(List2)), 
      assertz(mbList(List3)),
      assertz(mbdList(List4)), !.
 
  getNumbersNeverCalled() :-
      findall(N, (numberCount(num(N, C)), C=0), List),
      assert(nnc(List)),
      assert(numbersNeverCalled(List)).
       
  getMoneyBallsNeverCalled():-
      findall(N, (moneyBallCount(num(N, C)), C=0), List),
      assert(mbnc(List)),
      assert(moneyBallsNeverCalled(List)).
      
  getExtremeCalledNumbers():-
       retract(nList(C)),
       L = list::sort(C, ascending),
       M = list::sort(C, descending),
       getTop10Numbers(L, M),!.
  getExtremeCalledNumbers():-!.
       
  getExtremeCalledMoneyBalls() :-
       retract(mbList(C)),
       L = list::sort(C, ascending),
       M = list::sort(C, descending),
       getTop10MoneyBalls(L, M),!.
  getExtremeCalledMoneyBalls().
       
  getOldestNumbers() :-
       retract(ndList(C)),
       L = list::sort(C, descending),
       getTop10OldestNumbers(L),!.
   getOldestNumbers().
      
  getOldestMoneyBall() :-
       retract(mbdList(C)),
       L = list::sort(C, descending),
       getTop10OldestMoneyBalls(L),!.
  getOldestMoneyBall().

     
  getTop10Numbers([L1,  L2,  L3,  L4, L5,  L6,  L7,  L8,  L9, L10 | _], 
                             [M1, M2, M3, M4, M5, M6, M7, M8, M9, M10|_] ) :-
       numberCount(num(A1, L1)),
       numberCount(num(A2, L2)),
       A1 <> A2,
       numberCount(num(A3, L3)),
       A3 <> A2, A3 <> A1,
       numberCount(num(A4, L4)),
       A4 <> A3, A4 <> A2, A4 <> A1,
       numberCount(num(A5, L5)),
       A5 <> A4, A5 <> A3, A5<> A2, A5 <> A1,
       numberCount(num(A6, L6)),
       A6 <> A5, 
       numberCount(num(A7, L7)),
       A7 <> A6,
       numberCount(num(A8, L8)),
       A8 <> A7,
       numberCount(num(A9, L9)),
       A9 <> A8,
       numberCount(num(A10, L10)),
       A10 <> A9,
       LCNL   = [num(A1, L1), num(A2, L2), num(A3, L3), num(A4, L4), num(A5, L5), 
                     num(A6, L6), num(A7, L7), num(A8, L8), num(A9, L9), num(A10, L10)],
       LCNS   = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10],
       assertz(lcn(LCNL)),
       assertz(leastCalledNumbers(LCNS)),
       
       numberCount(num(B1, M1)),
       numberCount(num(B2, M2)),
       B1 <> B2,
       numberCount(num(B3, M3)),
       B3 <> B2, B3 <> B1,
       numberCount(num(B4, M4)),
       B4 <> B3, B4 <> B2, B4 <> B1,
       numberCount(num(B5, M5)),
       B5 <> B4, B5 <> B3, B5 <> B2, B5 <> B1,
       numberCount(num(B6, M6)),
       B6 <> B5,
       numberCount(num(B7, M7)),
       B7 <> B6,
       numberCount(num(B8, M8)),
       B8 <> B7,
       numberCount(num(B9, M9)),
       B9 <> B8,
       numberCount(num(B10, M10)),
       B10 <> B9,
       MCNL   = [num(B1, M1), num(B2, M2), num(B3, M3), num(B4, M4), num(B5, M5), 
                      num(B6, M6), num(B7, M7), num(B8, M8), num(B9, M9), num(B10, M10)],
       MCNS   = [B1, B2, B3, B4, B5, B6, B7, B8, B9, B10],
       assertz(mcn(MCNL)),
       assertz(mostCalledNumbers(MCNS)), !.
  getTop10Numbers(_,_). 

  getTop10MoneyBalls([L1,  L2,  L3,  L4, L5,  L6,  L7,  L8,  L9, L10 | _], 
                                 [M1, M2, M3, M4, M5, M6, M7, M8, M9, M10|_] ) :-
       moneyBallCount(num(A1, L1)),
       moneyBallCount(num(A2, L2)),
       A1 <> A2,
       moneyBallCount(num(A3, L3)),
       A3 <> A2, A3 <> A1,
       moneyBallCount(num(A4, L4)),
       A4 <> A3, A4 <> A2, A4 <> A1,
       moneyBallCount(num(A5, L5)),
       A5 <> A4, A5 <> A3, A5 <> A2, A5 <> A1,
       moneyBallCount(num(A6, L6)),
       A6 <> A5,
       moneyBallCount(num(A7, L7)),
       A7 <> A6,
       moneyBallCount(num(A8, L8)),
       A8 <> A7,
       moneyBallCount(num(A9, L9)),
       A9 <> A8,
       moneyBallCount(num(A10, L10)),
       A10 <> A9,
       LCMBL   = [num(A1, L1), num(A2, L2), num(A3, L3), num(A4, L4), num(A5, L5), 
                       num(A6, L6), num(A7, L7), num(A8, L8), num(A9, L9), num(A10, L10)],
       LCMBS   = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10],
       assertz(lcmb(LCMBL)),
       assertz(leastCalledMoneyBalls(LCMBS)),
       
       moneyBallCount(num(B1, M1)),
       moneyBallCount(num(B2, M2)),
       B1 <> B2,
       moneyBallCount(num(B3, M3)),
       B3 <> B2, B3 <> B1,
       moneyBallCount(num(B4, M4)),
       B4 <> B3, B4 <> B2, B4 <> B1,
       moneyBallCount(num(B5, M5)),
       B5 <> B4, B5 <> B3, B5 <> B2, B5 <> B1,
       moneyBallCount(num(B6, M6)),
       B6 <> B5,
       moneyBallCount(num(B7, M7)),
       B7 <> B6,
       moneyBallCount(num(B8, M8)),
       B8 <> B7,
       moneyBallCount(num(B9, M9)),
       B9 <> B8,
       moneyBallCount(num(B10, M10)),
       B10 <> B9,
       MCMBL   = [num(B1, M1), num(B2, M2), num(B3, M3), num(B4, M4), num(B5, M5), 
                        num(B6, M6), num(B7, M7), num(B8, M8), num(B9, M9), num(B10, M10)],
        MCMBS   = [B1, B2, B3, B4, B5, B6, B7, B8, B9, B10],
      assertz(mcmb(MCMBL)), 
      assertz(mostCalledMoneyBalls(MCMBS)), !.
  getTop10MoneyBalls(_,_). 
  
   getTop10OldestNumbers([L1,  L2,  L3,  L4, L5,  L6,  L7,  L8,  L9, L10 | _]):-
       numberDate(num(A1, L1)),
       numberDate(num(A2, L2)),
       A1 <> A2,
       numberDate(num(A3, L3)),
       A3 <> A2, A3 <> A1,
       numberDate(num(A4, L4)),
       A4 <> A3, A4 <> A2, A4 <> A1,
       numberDate(num(A5, L5)),
       A5 <> A4, A5 <> A3, A5 <> A2, A5 <> A1,
       numberDate(num(A6, L6)),
       A6 <> A5,
       numberDate(num(A7, L7)),
       A7 <> A6,
       numberDate(num(A8, L8)),
       A8 <> A7,
       numberDate(num(A9, L9)),
       A9 <> A8,
       numberDate(num(A10, L10)),
       A10 <> A9,
       OCNL   = [num(A1, L1), num(A2, L2), num(A3, L3), num(A4, L4), num(A5, L5), 
                      num(A6, L6), num(A7, L7), num(A8, L8), num(A9, L9), num(A10, L10)],
       OCNS   = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10],
       assertz(ocn(OCNL)),
       assertz(oldestCalledNumbers(OCNS)),!.
 getTop10OldestNumbers(_).
 
  getTop10OldestMoneyBalls([L1,  L2,  L3,  L4, L5,  L6,  L7,  L8,  L9, L10 | _]):-
       moneyBallDate(num(A1, L1)),
       moneyBallDate(num(A2, L2)),
       A1 <> A2,
       moneyBallDate(num(A3, L3)),
       A3 <> A2, A3 <> A1,
       moneyBallDate(num(A4, L4)),
       A4 <> A3, A4 <> A2, A4 <> A1,
       moneyBallDate(num(A5, L5)),
       A5 <> A4, A5 <> A3, A5 <> A2, A5 <> A1,
       moneyBallDate(num(A6, L6)),
       A6 <> A5,
       moneyBallDate(num(A7, L7)),
       A7 <> A6,
       moneyBallDate(num(A8, L8)),
       A8 <> A7,
       moneyBallDate(num(A9, L9)),
       A9 <> A8,
       moneyBallDate(num(A10, L10)),
       A10 <> A9,
       OCMBL   = [num(A1, L1), num(A2, L2), num(A3, L3), num(A4, L4), num(A5, L5), 
                        num(A6, L6), num(A7, L7), num(A8, L8), num(A9, L9), num(A10, L10)],
       OCMBS   = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10],
       assertz(ocmb(OCMBL)),
       assertz(oldestCalledMoneyBalls(OCMBS)), !.
getTop10OldestMoneyBalls(_).

constants
    className = "Lotto/convertData".
    classVersion = "".

clauses
    classInfo(className, classVersion).

end implement convertData
