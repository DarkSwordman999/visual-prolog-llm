/*****************************************************************************

		Copyright (c) My Company

 Project:  ALMACEN
 FileName: ALMACEN.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "almacen.inc"
  
  
domains

	identificador=integer
	diaentrada=integer
	diasalida=integer
	box=b(identificador,diaentrada,diasalida)
	lbox=box*
	actual=integer
	limite=integer
	pila=p(lbox,actual,limite)
	almacen=alm(pila,pila,pila,pila,pila)
	estado=est(lbox, almacen)
	lista=estado*
	
	
predicates
		
	/*perteneceapila(lbox, pila)*//*obtenemos la lista de cajas de la pila*/
	/*pilavacia(pila)*/
	cima(box,lbox)/*obtenemos la caja que se encuentra en la cima de la pila, es decir la ultima de lbox*/

	/*movercaja(pila,pila)*//*movemos la caja de una pila a otra para colocarla*/
	caja_valida(box,box)/*comparamos las fechas de salidas de la caja seleccionada y 
	la de la cima de la pila*/
	/*escribe(almacen)*//*escribimos la salida del programa*/
	/***
	****/
	mueve(estado,estado)
	miembro(estado,lista)
	pila(box,pila,pila)
	resuelve(lista)
	/*escribeEstado(estado)*/
	/*escribeAlmacen(almacen)*/

	
		
clauses




	/*comprobar la cajas*/
	cima(Box,[Box]).
	cima(Box,[_|Resto]):-
		cima(Box,Resto).
				
	caja_valida(b(_,_,DsalN),b(_,_,DsalA)):-
		DsalA >= DsalN.
		
	/*Estados repetidos */
        miembro(E,[E|_]).
        miembro(E,[_|T]):-
        	miembro(E,T).
        	
       	mueve(est(LProduccionIni,AlmacenI),est([CajaNoValida|LProduccionFin],AlmacenF)):-
        	LProduccionIni=[CajaNoValida|ListaSiguienteCaja],
        	mueve(est(ListaSiguienteCaja,AlmacenI),est(LProduccionFin,AlmacenF)).
        	
        /*Inicio mueve colocar cajas*/
        mueve(est(LProduccion, alm(PilaI,Pila2,Pila3,Pila4,Pila5)),est(Lfinal, alm(PilaF,Pila2,Pila3,Pila4,Pila5))):-
        	LProduccion=[Box|Resto],
        	pila(Box,PilaI,PilaF),
        	Lfinal=Resto.
        	
        mueve(est(LProduccion, alm(Pila1,PilaI,Pila3,Pila4,Pila5)),est(Lfinal, alm(Pila1,PilaF,Pila3,Pila4,Pila5))):-
        	LProduccion=[Box|Resto],
        	pila(Box,PilaI,PilaF),
        	Lfinal=Resto.
        	
        mueve(est(LProduccion, alm(Pila1,Pila2,PilaI,Pila4,Pila5)),est(Lfinal, alm(Pila1,Pila2,PilaF,Pila4,Pila5))):-
        	LProduccion=[Box|Resto],
        	pila(Box,PilaI,PilaF),
        	Lfinal=Resto.
        	
        mueve(est(LProduccion, alm(Pila1,Pila2,Pila3,PilaI,Pila5)),est(Lfinal, alm(Pila1,Pila2,Pila3,PilaF,Pila5))):-
        	LProduccion=[Box|Resto],
        	pila(Box,PilaI,PilaF),
        	Lfinal=Resto.
        	
        mueve(est(LProduccion, alm(Pila1,Pila2,Pila3,Pila4,PilaI)),est(Lfinal, alm(Pila1,Pila2,Pila3,Pila4,PilaF))):-
        	LProduccion=[Box|Resto],
        	pila(Box,PilaI,PilaF),
        	Lfinal=Resto.
        	
        pila(Box,p(Lbox,0,Limite),PilaF):-
        	NLbox=[Box|Lbox],
        	PilaF=p(NLbox,1,Limite).
        		
        pila(Box,p(Lbox,Actual,Limite),PilaF):-
        	Actual<Limite,
        	cima(Cima,Lbox),
        	caja_valida(Box,Cima),
        	NLbox=[Box|Lbox],
        	NActual=Actual+1,
        	PilaF=p(NLbox,NActual,Limite).
        	
        
        		
	resuelve([est([],Almacen)|_]):-
		write(Almacen).
		
	resuelve(Estados):-
		Estados=[UltimoEstado|Resto],
        	not(miembro(UltimoEstado,Resto)),
        	mueve(UltimoEstado,SiguienteEstado),
        	NuevoEstados=[SiguienteEstado|Estados],
        	resuelve(NuevoEstados).
			
		
        /*escribeEstado(est(Lbox,Almacen)):-
       			escribeAlmacen(Almacen).
			*/
	/*escribeAlmacen(alm(p(Lbox,Actual,Limite),Pila2,Pila3,Pila4,Pila5)):-
			write(Pila2,"\n").*/
			

goal

  
  	resuelve([est([b(9,1,17),b(10,1,17),b(11,1,35),b(12,1,17),b(13,1,17),b(14,1,17),b(15,1,17),b(16,1,17),b(17,1,17),b(18,1,17),b(19,1,17),b(20,1,17),b(3,1,18),b(4,1,18),b(5,1,18),b(6,1,18),b(7,1,18),b(8,1,18),b(1,1,19),b(2,1,19)],alm(p([],0,4),p([],0,4),p([],0,4),p([],0,4),p([],0,4)))|[]]).
	