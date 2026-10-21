/*****************************************************************************

		Copyright (c) My Company

 Project:  PARCIALES
 FileName: ORDENAR.PRO
 Purpose: Ordenar una lista
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "parciales.inc"

domains
	lista = Integer*

predicates
	nondeterm ordenar (lista,lista)
	nondeterm menor (Integer,Integer,Integer)
	nondeterm minimo (lista,Integer)
	nondeterm eliminar (Integer,lista,lista)

clauses
	menor (A,B,C):-
		A<B,C=A.
	menor (A,B,C):-
		A>=B,C=B.

	minimo ([Ca],Ca).

	minimo([Ca|[Ca1|Co1]],M):-
		menor(Ca,Ca1,X),
		minimo([X|Co1],M).


	eliminar (_,[],[]).
	
	eliminar (X,[X|Co],Co).

	eliminar (X,[Ca|Co],[Ca1|Co1]):-
		Ca<>X,
		Ca1=Ca,
		eliminar (X,Co,Co1).

	ordenar ([Elem],[Elem]).

	ordenar (L,[Ca|Co]):-
		minimo(L,M),
		eliminar(M,L,L2),
		Ca=M,
		ordenar (L2,Co).

goal
	ordenar ([1,3,3,3,3,2,1],Lista).