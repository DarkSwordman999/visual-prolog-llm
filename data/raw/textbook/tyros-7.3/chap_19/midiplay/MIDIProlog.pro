DOMAINS
listaInteiros = integer*

PREDICATES
nondeterm nota (string,integer).
nondeterm tempo (string,integer).
nondeterm insereElLista(integer,listaInteiros,listaInteiros).
nondeterm concatena (listaInteiros,listaInteiros,listaInteiros).
nondeterm contaElementos (listaInteiros,integer).
nondeterm inicio.
nondeterm criaArqMIDI(listaInteiros).
nondeterm parar(char,listaInteiros).
cabecalhoPrincipal (listaInteiros).
cabecalhoTrack (listaInteiros).
eventosConfig(listaInteiros)
fimArquivo (listaInteiros).
transInt4Bytes(integer,listaInteiros).
volume(integer,integer).

DATABASE
arquivoMIDI(listaInteiros). %criado para o caso de se desejar modificar o formato ou a ppq

CLAUSES
%inicio inicia a lista do Arquivo MIDI formato 0 com o cabeзalho principal e o lable do track
inicio:-  cabecalhoPrincipal(Mthd),cabecalhoTrack(Mtrk),concatena(Mthd,Mtrk,Cab),asserta(arquivoMIDI(Cab)),criaArqMIDI([]).

criaArqMIDI(Mus):- 
              write("Entre com uma nota musical de do5 a si5",'\n',"nota-> "),
              readln(Nota),nota(Nota,N1),nl, 
              write("Entre com a figura musical da nota ", Nota,'\n',"figura musical-> "),
              readln(Figura),tempo(Figura,F1),nl,
              write("Entre com o volume da nota ", Nota,'\n',"volume(0 a 127)-> "),
              readInt(Volume),volume(Volume,VolumeCerto),
              concatena(Mus,[0,144,N1,VolumeCerto,F1,128,N1,0],MusNova),nl,
              write("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"),nl,
              write("Musica Atual = ",MusNova),nl,
              write("Deseja parar ?",'\n',"(s/n)-> "),
              readChar(C),nl,
              parar(C,MusNova).
%para simplificar, esta se adotando que o track musical, incluindo os 4 Bytes do fim de track, nгo ultrapassem o valor 255.
%Caso isto ocorra, dever-se-б criar um predicado para transformar um inteiro em quatro Bytes e criar uma lista com os mesmos
%para concatenar com o cabeзalho MIDI, conforme a claъsuca parar.
parar('s',M):- contaElementos(M,N1),Cont = N1 + 4,transInt4Bytes(Cont,T4B),retract(arquivoMIDI(CabecTrack)),fimArquivo(F),
               concatena(CabecTrack,T4B,M1),
               concatena(M1,M,M2),
               concatena(M2,F,MusicaMIDI),
               write("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"),nl,
               write("Arquivo MIDI Final = ",MusicaMIDI),nl,              
               write("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"),
               asserta(arquivoMIDI(MusicaMIDI)),exit. %grava o arquivo final no topo do predicado arquivoMIDI             
parar(_,M):-   criaArqMIDI(M).


%notas vгo do inteiro 0 ao inteiro 127
nota("do5",60):-!.
nota("do#5",61):-!. 
nota("re5",62):-!.
nota("re#5",63):-!.
nota("mi5",64):-!.
nota("fa5",62):-!.
nota("fa#5",63):-!.
nota("sol5",64):-!.
nota("sol#5",62):-!.
nota("la5",63):-!. % lб 440Hz diapasгo
nota("la#5",63):-!.
nota("si5",64):-!.
nota(_,60):-!.%qualquer nota digitada errada ou inexistente devolverб o cуdigo da nota dу5

%tempo й calculado de acordo com a ppq escolhida, no caso, 48 (cabзalho principal)
tempo("minima",96):-!.
tempo("seminima",48):-!.
tempo("concheia",24):-!.
tempo("semicolcheia",12):-!.
tempo("fusa",6):-!.
tempo(_,96):-!. %qualquer outro tempo serб adotado o de uma semнnima

% o volume tem que ser menor que 127
volume(X,X):- X<128,!.
volume(_,100):-!.

%eventosConfig й uma lista contendo o metrфnomo (tempo da semнnima em microsegundos), 
%                                     fуrmula de compasso(time signature), armadura de clave(tonalidade) (Key signature)                                   
cabecalhoPrincipal([77, 84, 104, 100, 0, 0, 0, 6, 0, 0, 0, 1, 0, 48]).  %cabecalho principal - 14 Bytes contendo formato, nъmero de tracks e ppq (pulses per quarte note - semнmina)
cabecalhoTrack ([77, 84, 114, 107]).
eventosConfig([0, 255, 89, 2, 0, 0, 0, 255, 81, 3, 7, 161, 32, 0, 255, 88, 4, 2, 2, 24, 8, 0, 192, 24, 0, 193, 24]).
fimArquivo ([0,255,42,0]).

% clбusulas auxiliares
insereElLista(E,[],[E]).
insereElLista(E,L,[E|L]).

concatena([],L,L).
concatena([H|R1],L2,[H|R]):-concatena(R1,L2,R).

contaElementos([],0).
contaElementos([_|R],N):-contaElementos(R,N1), N=N1+1.

transInt4Bytes(N,[0,0,0,N]):-N<256,!.
transInt4Bytes(N,[0,0,N1,N2]):-N>256,N<65535, N2 = N mod 256, N1 = abs(N/256),!.

GOAL
inicio.