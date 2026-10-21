/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB_15
 FileName: LAB_15.PRO
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
	
	s = real.
	property = building(price, s); 
		area(price, s); 
		water_transport(price, years);
		phone_book(phone, address);
		car(brand, color, price, years).
		
	cur_property = symbol.
	
PREDICATES
	investor(surname, bank, account, sum).
	phone_book(surname, phone, address).
	
	own(surname, property).
	
	property_price_by_owner(surname, cur_property, price).
	
	get_price_by_owner(surname, cur_property, price).
	
	sum_price(Surname, sum)

CLAUSES
	investor("Birukova", "New_1", deposit, 1000000).
	investor("Mironova", "Old_bank", deposit, 5000).
	investor("Nikiforov", "VTB", deposit, 5000).
	
	phone_book("Birukova", "+123456", address("Moscow", "Zhukovsky Street", 12, 145)).
	phone_book("Mironova", "+333333", address("Ramenskoe", "New Street", 77, 77)).
	
	own("Birukova", building(1000000, 50)).
	own("Birukova", area(750000, 120)).
	own("Birukova", water_transport(5000000, 1)).
	own("Filin", water_transport(55000000, 2)).
	
	own("Birukova", car("BMW", black, 4500000, 2)).
	own("Filin", car("Honda", grey, 2300000, 4)).
	own("Nikiforov", car("Honda", grey, 2000000, 6)).
	
	property_price_by_owner(Surname, building, Price) :- own(Surname, building(Price, _)).
	property_price_by_owner(Surname, area, Price) :- own(Surname, area(Price, _)).
	property_price_by_owner(Surname, water_transport, Price) :- own(Surname, water_transport(Price, _)).
	property_price_by_owner(Surname, car, Price) :- own(Surname, car(_, _, Price, _)).
	
	get_price_by_owner(Surname, building, Price) :- own(Surname, building(Price, _)), !.
	get_price_by_owner(Surname, area, Price) :- own(Surname, area(Price, _)), !.
	get_price_by_owner(Surname, water_transport, Price) :- own(Surname, water_transport(Price, _)), !.
	get_price_by_owner(Surname, car, Price) :- own(Surname, car(_, _, Price, _)), !.
	get_price_by_owner(_, _, 0).
	
	sum_price(Surname, Sum) :- 
		get_price_by_owner(Surname, building, Price1),
		get_price_by_owner(Surname, area, Price2),
		get_price_by_owner(Surname, water_transport, Price3),
		get_price_by_owner(Surname, car, Price4),
		Sum = Price1 + Price2 + Price3 + Price4.
		
	
	
GOAL
	%property_price_by_owner("Mishina", Property, _).
	
	%property_price_by_owner("Mishina", Property, Price).
	
	sum_price("Mishina", Sum).
	
	
