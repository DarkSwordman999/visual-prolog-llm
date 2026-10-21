country(england).
country(france).
country(germany).
country(denmark).

print_countries :-
      country(X),
      write(X), 
      nl,             
      fail.
      
print_countries.



