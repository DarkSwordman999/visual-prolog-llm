/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB_12
 FileName: LAB_12.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

DOMAINS
	name, surname, subj, unv = symbol.
	
PREDICATES
	student(name, surname, unv).
	teacher(name, surname, subj, unv).
	
CLAUSES
	student("Ann", "Richy", "unv_1").
	student("Boby", "Adamson", "unv_3").
	student("Boby", "Dicson", "unv_1").
	student("Galya", "Backer", "unv_2").
	student("Gigi", "Dyson", "unv_1").
	student("Gigi", "Dyson", "unv_2").
	student("Gigi", "Dyson", "unv_3").
	
	student("Tanya", "Park", Unv):-student("Ann", "Richy", Unv).
	
	teacher("Kristina", "Nikiforova", "physics", "unv_2").
	teacher("Mila", "Kolovanova", "english", "unv_2").
	teacher("Anton", "Popov", "drawing", "unv_4").
	
GOAL
	%student(Name, Surname, "unv_1"). 
	
	%student("Boby", Surname, "unv_2").
	
	%teacher(_, _, "english", "unv_2").
	
	%teacher(Name, Surname, Subj, "unv_4").
	
	teacher("Mila", "Kolovanova", "english", "unv_2").
