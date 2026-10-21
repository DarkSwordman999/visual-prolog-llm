%File network.pro
implement network
    open core
constants
    className = "network/network".
    classVersion = "".
facts
   weight:(unsigned, real).
   eg:(unsigned, real, real, real).

clauses

sigmoid(X)= 1.0/(1.0+math::exp(-X)).

getWgt_nd(I, R) :- weight(I, R).

assertWgt(I, R) :- asserta(weight(I, R)).

popweight(I, W) :- retract(weight(I, W)), !.
popweight(_, _).

setExamples(Es) :- retractall(eg(_,_,_,_)), 
                         setEx(0, Es).

setEx(_N, []) :- !.
setEx(N, [e(I1, I2,R)|Es]) :-
    assertz(eg(N, I1, I2, R)),
    setEx(N+1, Es).

egratia(Eg, I1, I2, Output) :- eg(Eg, I1, I2, Output), !.
egratia(Eg, I1, I2, Output) :- Ex = Eg rem 4,
                               eg(Ex, I1, I2, Output), !.
egratia(_Eg, 1, 1, 0).

setWeight(Qs) :- 
    retractall(weight(_,_)),
    foreach tuple(X, WX)= list::getMember_nd(Qs) do
       assert(weight(X, WX))
    end foreach.

getWgt(I, W) :- weight(I, W), !.
getWgt(_I, 0.0).

predicted_out(Obj, V) :- 
  hidden(Obj, [3,4,5], I_1),
  hidden(Obj, [6,7,8], I_2),
  getWgt(0, W_0),
  getWgt(1, W_1),
  getWgt(2, W_2),
   X = W_0+W_1* I_1 + W_2* I_2,
   V= sigmoid(X).

hidden(Obj,[A,B,C],V) :- eg(Obj, I_1, I_2, _), !,
  getWgt(A, WA),
  getWgt(B, WB),
  getWgt(C, WC),
   XX = WA+WB* I_1+WC* I_2,
   V=sigmoid(XX).
hidden(_, _, 0).

usit( [I1, I2], V) :-
     getWgt(0, W_0),  getWgt(1, W_1),  getWgt(2, W_2),
     getWgt(3, W_3),  getWgt(4, W_4), getWgt(5, W_5),
     getWgt(6, W_6),  getWgt(7, W_7),  getWgt(8, W_8), !,
     X1 = W_3 + W_4*I1 + W_5*I2,
     V1=sigmoid(X1),
     X2 =  W_6 + W_7*I1 + W_8*I2,
     V2= sigmoid(X2),
     VX = W_0 + W_1*V1 + W_2*V2,
     V= sigmoid(VX).
 usit( _, 0).
end implement network
