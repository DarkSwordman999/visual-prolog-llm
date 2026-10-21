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
	
	car_by_phone(phone, surname, brand, price).
	
	brand_by_phone(phone, brand).
	
	address_by_surname_city(surname, city, street, bank, phone).

CLAUSES
	phone_book("Birukova", "+123456", address("Moscow", "Zhukovsky Street", 12, 145)).
	phone_book("Nikiforov", "+987456", address("Zhukovsky", "Gagarin Street", 64, 32)).
	phone_book("Nikiforov", "+111111", address("Zhukovsky", "Gagarin Street", 64, 32)).
	phone_book("Mironova", "+909090", address("Zhukovsky", "Sunny Street", 2, 89)).
	phone_book("Filin", "+444000", address("Ramenskoe", "Central", 1, 1)).
	phone_book("Mironova", "+333333", address("Ramenskoe", "New Street", 77, 77)).
	
	car("Birukova", "BMW", black, 4500000, 2).
	car("Birukova", "Ford", white, 6200000, 1).
	car("Filin", "Honda", grey, 2300000, 4).
	
	investor("Birukova", "New_1", deposit, 1000000).
	investor("Legneva", "Old_bank", special, 2370000).
	investor("Mironova", "Old_bank", deposit, 5000).
	
	
	car_by_phone(Phone, Surname, Brand, Price) :- 
		phone_book(Surname, Phone, _),
		car(Surname, Brand, _, Price, _).
		
	brand_by_phone(Phone, Brand) :-
		car_by_phone(Phone, _, Brand, _).	
		
	address_by_surname_city(Surname, City, Street, Bank, Phone) :-
		phone_book(Surname, Phone, address(City, Street, _, _)),
		investor(Surname, Bank, _, _).

GOAL
	%car_by_phone("+123456", Surname, Brand, Price).
	%car_by_phone("+000000", Surname, Brand, Price).
	%car_by_phone("+444000", Surname, Brand, Price).
	
	%brand_by_phone("+123456", Brand).
	%brand_by_phone("+444000", Brand).
	%brand_by_phone("+******", Brand).
	
	%address_by_surname_city("Mironova", "Zhukovsky", Street, Bank, Phone).
	%address_by_surname_city("Legneva", "Ramenskoe", Street, Bank, Phone).
	
