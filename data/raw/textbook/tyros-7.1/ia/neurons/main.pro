%File: main.pro
implement main
    open core
constants
    className = "main".
    classVersion = "nnxor".
clauses
    classInfo(className, classVersion).

class facts
   acc:real := 0.0.
   nn:network := erroneous.

class predicates
  evalError:(unsigned Obj, real Err) procedure (i, o).
  errSum:(unsigned* Exs,
     real Partial_err, real Total_err) procedure (i,    i, o).
  updateWeight:(real DX, real LC, unsigned* Exs) procedure (i, i, i).

clauses
   evalError(Obj, E) :- nn:predicted_out(Obj, VC),
         nn:egratia(Obj, _I1, _I2, V),
         E= (VC-V)*(VC-V).

  errSum(Exs,  _Partial_err, Total_err) :- acc := 0.0,
     foreach Eg= list::getMember_nd(Exs) do
        evalError(Eg, Err),
        acc := acc + Err
     end foreach,
     Total_err= acc.

 updateWeight(DX, LC, Exs) :- errSum(Exs, 0.0, Err0),
      PN= [tuple(I, W) || nn:getWgt_nd(I, W)],
      nn:setWeight([tuple(P, NV) || tuple(P, V)= list::getMember_nd(PN),
                           V1= V+DX,
                           nn:assertWgt(P, V1),
                           errSum(Exs,  0.0, Nerr),
                           nn:popweight(P, V1),
                           NV= V+LC*(Err0-Nerr)/DX]).


 class predicates
   train:(real DX, real LC,  unsigned* Exs) procedure (i,  i, i).
 clauses
   train(DX, LC, Exs) :- errSum(Exs,  0, Err0),
     if (Err0 < 0.1)  then
         stdio::write("Total Err: ", Err0), stdio::nl
     else
       updateWeight(DX, LC, Exs),
       train(DX, LC, Exs)
     end if.

class predicates
   training:(network,  real, real) procedure (i,  i, i).
clauses
  training(NN,  _DX, _LC) :- nn := NN,
      WWW= [ tuple(0,0),tuple(1,2),tuple(2,0),
            tuple(3,0),tuple(4,1),tuple(5,0),
            tuple(6,0),tuple(7,0),tuple(8,0)],
     nn:setWeight(WWW),
     train(0.001,0.1,[0,1,2,3, 1, 2, 3, 0, 3, 2, 1, 0]).

    run():- console::init(),
        XOR = network::new(), AND = network::new(),
        XOR:setExamples([ network::e(1,1,0), network::e(1,0,1),
                          network::e(0,1,1), network::e(0,0,0)]),
        AND:setExamples([ network::e(1,1,1), network::e(1,0,0),
                          network::e(0,1,0), network::e(0,0,0)]),
        training(XOR,  0.001, 0.5),
        training(AND,  0.001, 0.5),
        XOR:usit( [1,1], XOR11), stdio::nl,
        stdio::write("xor(1,1)=", XOR11), stdio::nl,
        XOR:usit( [1,0], XOR10), stdio::nl,
        stdio::write("xor(1,0)=", XOR10), stdio::nl,
        XOR:usit( [0,1], XOR01), stdio::nl,
        stdio::write("xor(0,1)=",  XOR01), stdio::nl,
        XOR:usit( [0,0], XOR00), stdio::nl,
        stdio::write("xor(0,0)=", XOR00), stdio::nl, stdio::nl,
        AND:usit( [1,1], AND11), stdio::nl,
        stdio::write("1&&1=", AND11), stdio::nl,
        AND:usit( [1,0], AND10), stdio::nl,
        stdio::write("1&&0=", AND10), stdio::nl,
        AND:usit( [0,1], AND01), stdio::nl,
        stdio::write("0&&1=",  AND01), stdio::nl,
        AND:usit( [0,0], AND00), stdio::nl,
        stdio::write("0&&0=",  AND00), stdio::nl.

end implement main

goal
    mainExe::run(main::run).
