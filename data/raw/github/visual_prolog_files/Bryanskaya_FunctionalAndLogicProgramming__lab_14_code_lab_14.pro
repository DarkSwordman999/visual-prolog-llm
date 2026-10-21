/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB_13
 FileName: LAB_13.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

DOMAINS
	surname, phone = symbol.
	
	city, street = symbol.
	home, flat = integer.
	
	brand, color = symbol.
	price = real.
	years = integer.
	
	bank, account = symbol.
	sum = real.
	
	address = address(city, street, home, flat).
	
PREDICATES
	phone_book(surname, phone, address).
	
	car(surname, brand, color, price, years).
	
	investor(surname, bank, account, sum).
	
	get_by_brand_color(brand, color, surname, city, phone, bank).

CLAUSES
	phone_book("Birukova", "+123456", address("Moscow", "Zhukovsky Street", 12, 145)).
	phone_book("Nikiforov", "+987456", address("Zhukovsky", "Gagarin Street", 64, 32)).
	phone_book("Mironova", "+909090", address("Zhukovsky", "Sunny Street", 2, 89)).
	phone_book("Filin", "+444000", address("Ramenskoe", "Central", 1, 1)).
	phone_book("Mironova", "+333333", address("Ramenskoe", "New Street", 77, 77)).
	
	car("Birukova", "BMW", black, 4500000, 2).
	car("Birukova", "Ford", white, 6200000, 1).
	car("Filin", "Honda", grey, 2300000, 4).
	car("Nikiforov", "Honda", grey, 2000000, 6).
	
	investor("Birukova", "New_1", deposit, 1000000).
	investor("Legneva", "Old_bank", special, 2370000).
	investor("Mironova", "Old_bank", deposit, 5000).
	investor("Nikiforov", "VTB", deposit, 5000).
	investor("Filin", "New_bank", deposit, 10).
	
		
	get_by_brand_color(Brand, Color, Surname, City, Phone, Bank) :-
		car(Surname, Brand, Color, _, _),
		phone_book(Surname, Phone, address(City, _, _, _)),
		investor(Surname, Bank, _, _).

GOAL
	%get_by_brand_color("BMW", red, Surnamet, Cityt, Phonet, Bankt).
	%get_by_brand_color("BMW", black, Surnamet, Cityt, Phonet, Bankt).
	get_by_brand_color("Honda", grey, Surnamet, Cityt, Phonet, Bankt).
	
	

