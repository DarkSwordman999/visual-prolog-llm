/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB_11
 FileName: LAB_11.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

/* Program about set of students studing at the same university
 1. only facts 
 2. rules
 3. create your own base of knowledge */

DOMAINS
	name, surname, subj, unv = symbol.
	
PREDICATES
	student(name, surname, unv).
	teacher(name, surname, subj, unv).
	
CLAUSES
	student("Ann", "Richy", "unv_1").
	student("Boby", "Adamson", "unv_3").
	student("Galya", "Backer", "unv_2").
	student("Gigi", "Dyson", "unv_1").
	
	student("Tanya", "Park", Unv):-student("Ann", "Richy", Unv).
	
	teacher("Kristina", "Nikiforova", "physics", "unv_2").
	teacher("Mila", "Kolovanova", "english", "unv_2").
	teacher("Anton", "Popov", "drawing", "unv_4").
	
GOAL
	%student("Boby", "Adamson", "unv_3").
	 
	%student(Name, Surname, "unv_1").
	
	%student("Galya", Surname, "unv_2").
	
	%teacher(_, _, _, "unv_2").
	
	%teacher(Name, Surname, Subj, "unv_2").

	teacher(Name, Surname, Subj, "unv_100").	 
