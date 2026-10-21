/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/

implement getNumbers
    open core, lottoDomains, convertData, file, string, math, list


constants
    className = "Lotto/getNumbers".
    classVersion = "".

class facts - displayNumbers
    leastCalledNumbers : (string LCN).
    mostCalledNumbers: (string MCN).
    oldestCalledNumbers : (string OCN).
    leastCalledRandom : (string LCR).
    randomLotto1 : (string RL1).
    
class facts - tempLocal
    regularNumbers : (number* RN).
    moneyBallNumbers : (number* MBN).
    
class predicates
    historyDataConvert : (number*, number*, number*, number*, number*, number*) determ (i, i, i, i, i, i).
    convertListToString : (number*, number*, string) determ (i, i, o).
    get_Random_LCN : (number*, number*).
    get_Random : ().
    writeMessages : (number*, number*, number*, number*, number*, number*, number*, number*).
    % getHelp : (inputStream I) multi (i).
    
clauses
    history (DisplayData):-
        existFile("LottoData.txt"),
        getHistoryData(LCN, LCMB, MCN, MCMB, OCN, OCMB, NCN, NCMB),
        historyDataConvert(LCN, LCMB, MCN, MCMB, OCN, OCMB),
        get_Random_LCN(LCN, LCMB),
        get_Random(),
        leastCalledNumbers(S1),
        mostCalledNumbers(S2),
        oldestCalledNumbers(S3),
        leastCalledRandom(S4),
        randomLotto1(S5),
        DisplayData = [S1, S2, S3, S4, S5],
        writeMessages(LCN, LCMB, MCN, MCMB, OCN, OCMB, NCN, NCMB), !.
        
    history (DisplayData):-
        existFile("LottoData.txt"),
        getHistoryDataAgain,
        getHistoryData(LCN, LCMB, MCN, MCMB, OCN, OCMB, NCN, NCMB),
        historyDataConvert(LCN, LCMB, MCN, MCMB, OCN, OCMB),
        get_Random_LCN(LCN, LCMB),
        get_Random(),
        leastCalledNumbers(S1),
        mostCalledNumbers(S2),
        oldestCalledNumbers(S3),
        leastCalledRandom(S4),
        randomLotto1(S5),
        DisplayData = [S1, S2, S3, S4, S5],
        writeMessages(LCN, LCMB, MCN, MCMB, OCN, OCMB, NCN, NCMB), !.
        
    history (["", "" ,"", "", ""]):-
        stdio::write("Data Has Not been imported - Import data First \n\n" ),!.

    writeMessages(LCN, LCMB, MCN, MCMB, OCN, OCMB, NCN, NCMB) :-
        stdio::write("Least Called Numbers : ", LCN, "\n"),
        stdio::write("Least Called Money Balls : ", LCMB, "\n"),
        stdio::write("Most Called Numbers : ", MCN, "\n"),
        stdio::write("Most Called Money Balls : ", MCMB, "\n"),
        stdio::write("Oldest Called Numbers : ", OCN, "\n"),
        stdio::write("Oldest Called Money Balls: ", OCMB, "\n"),
        stdio::write("Never Called Numbers : ", NCN, "\n"),
        stdio::write("Never Called Money Balls : ", NCMB, "\n\n\n"), !.
        
    get_Random_LCN(LCN, LCMB):-
        N1 = tryGetNth(math::random(9), LCN),
        N2 = tryGetNth(math::random(9), LCN),
        N3 = tryGetNth(math::random(9), LCN),
        N4 = tryGetNth(math::random(9), LCN),
        N5 = tryGetNth(math::random(9), LCN),
        RandLCN = list::sort([N1, N2, N3, N4, N5]),
        NewList = list::removeDuplicates(RandLCN),
        list::length(NewList) = 5,
        RandLCMB = tryGetNth(math::random(9), LCMB),
        convertListToString(RandLCN, [RandLCMB], S),
        assert(leastCalledRandom(S)), !.
        
    get_Random_LCN(LCN, LCMB):- get_Random_LCN(LCN, LCMB).
    
    get_Random():-
        assert(regularNumbers([ 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,
            15,16,17,18,19,20,21,22,23,24,25,26,27,
            28,29,30, 31,32,33,34,35,36,37,38,39,
            40,41,42,43,44,45,46,47,48,49,50,51,52,
            53,54,55,56])),
        assert(moneyBallNumbers([ 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,
            15,16,17,18,19,20,21,22,23,24, 25,26,
            27,28,29,30,31,32,33,34,35,36,37,38,
            39,40,41,42,43,44,45,46])),
        regularNumbers(Ns),
        moneyBallNumbers(MBs),
        N1 = tryGetNth(math::random(55)+1, Ns),
        N2 = tryGetNth(math::random(55)+1, Ns),
        N3 = tryGetNth(math::random(55)+1, Ns),
        N4 = tryGetNth(math::random(55)+1, Ns),
        N5 = tryGetNth(math::random(55)+1, Ns),
        RN = list::sort([N1, N2, N3, N4, N5]),
        NewList = list::removeDuplicates(RN),
        list::length(NewList) = 5,
        RMB = [tryGetNth(math::random(45)+1, MBs)],
        convertListToString(RN, RMB, S),
        assert(randomLotto1(S)),
        retract(regularNumbers(_)),
        retract(moneyBallNumbers(_)), !.
        
    get_Random():- get_Random().
    
    randomAgain(RL, R):-
        retract(leastCalledRandom(_)),
        retract(randomLotto1(_)),
        getHistoryData(LCN, LCMB, _, _, _, _, _, _),
        get_Random_LCN(LCN, LCMB),
        get_Random(),
        leastCalledRandom(RL),
        randomLotto1(R),!.    
    randomAgain("", "") :- !.
                    
    historyDataConvert(LCN, LCMB, MCN, MCMB, OCN, OCMB) :-
        convertListToString(LCN, LCMB, S1),
        convertListToString(MCN, MCMB, S2),
        convertListToString(OCN, OCMB, S3),
        assertz(leastCalledNumbers(S1)),
        assertz(mostCalledNumbers(S2)),
        assertz(oldestCalledNumbers(S3)),
        file::save(lottoNumbers, displayNumbers), !.
        
    convertListToString([N1, N2, N3, N4, N5 | _], [MB | _], String) :-
        S1 = concat(toString(N1), ", "),
        S2 = concat(toString(N2), ", "),
        S3 = concat(toString(N3), ", "),
        S4 = concat(toString(N4), ", "),
        S5 = concat(toString(N5), " "),
        S6 = concat("- ", toString(MB)),
        String = concat(S1, S2, S3, S4, S5, S6), !.
        
    saveHistory():-
        file::existFile(lottoNumbers),
        file::delete(lottoNumbers),
        file::save(lottoNumbers, displayNumbers),
        retract(leastCalledNumbers(_)),
        retract(mostCalledNumbers(_)),
        retract(oldestCalledNumbers(_)),
        retract(leastCalledRandom(_)),
        retract(randomLotto1(_)),!.
        
    saveHistory():-
        file::save(lottoNumbers, displayNumbers),
        retract(leastCalledNumbers(_)),
        retract(mostCalledNumbers(_)),
        retract(oldestCalledNumbers(_)),
        retract(leastCalledRandom(_)),
        retract(randomLotto1(_)),!.
        
    saveHistory():- !.

clauses
    classInfo(className, classVersion).

end implement getNumbers
