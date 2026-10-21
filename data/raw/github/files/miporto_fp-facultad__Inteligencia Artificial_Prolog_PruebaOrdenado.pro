/*****************************************************************************

		Copyright (c) My Company

 Project:  PARCIALES
 FileName: PRUEBAORDENADO.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "parciales.inc"

domains
	lista = Integer*

predicates
	nondeterm orden (lista)
	nondeterm ordenS(lista)
	nondeterm ordenI(lista)

clauses
	orden ([]).
	
	orden (L) :- ordenS(L).
	
	orden (L) :- ordenI(L).
	
	ordenS ([_]).
	
	ordenS([Ca|[Ca1|Co1]]):-
		Ca >= Ca1,
		ordenS([Ca1|Co1]).
	
	ordenI ([_]).
	
	ordenI([Ca|[Ca1|Co1]]):-
		Ca <= Ca1,
		ordenI([Ca1|Co1]).

goal

	orden ([7,5,1]).