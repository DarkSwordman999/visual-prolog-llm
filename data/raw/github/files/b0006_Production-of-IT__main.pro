implement main
    open core
domains
    name = string.

class facts
% факты:
canuse : (name).                          % хочет проложить сеть
have_cabel : (name).                    % имеет достаточное количество кабеля
eco_to_shina: (name).                  % дешевле Шина
safe_to_star: (name).                   %надежнее звезда, но дороже чем Шина
gold_to_circle: (name).                 %надежнее чем Шина, и дешевле чем звезда

a_lot_of_cabel : (name).         % Шина требует ..
have_centr_usel : (name).      % Звезда требует ..
have_net_control : (name ).    %Кольцо требует ..

chose_a_topologia: (name).     % субъект прокладывает сеть за время..

class predicates
% действия:
can_use_to_topology : (name) nondeterm anyflow.  % Д1
choose_shina : (name) nondeterm anyflow.             % Д2
choose_star : (name) nondeterm anyflow.               % Д3
choose_circle : (name) nondeterm anyflow.             % Д4

take_so_many_cabel : (name) nondeterm anyflow.             % Д5
take_so_many_centr_usel : (name) nondeterm anyflow.     % Д6
take_so_local_controller : (name) nondeterm anyflow.        %Д7

waiting_time_50min : (name) nondeterm anyflow.        % Д8
waiting_time_30min : (name) nondeterm anyflow.        % Д9
waiting_time_40min : (name) nondeterm anyflow.        %Д10
get_a_file : (name) nondeterm anyflow.                      % Д11

clauses
% П1
can_use_to_topology(Name):- canuse(Name), have_cabel(Name).
% П2
choose_shina(Name):- can_use_to_topology(Name), eco_to_shina(Name).
% П3
choose_star(Name):- can_use_to_topology(Name), not(eco_to_shina(Name)).
% П4
choose_circle(Name):-can_use_to_topology(Name), eco_to_shina(Name), not(safe_to_star(Name)). %------------------------
% П5
take_so_many_cabel(Name):- choose_shina(Name), a_lot_of_cabel("A lot of cabel").
% П6
take_so_many_centr_usel(Name):- choose_star(Name), have_centr_usel("CentrUsel").
% П7
take_so_local_controller(Name):- choose_circle(Name), have_net_control("NetControl").
% П8
waiting_time_50min(Name) :- take_so_many_cabel(Name).
% П9
waiting_time_30min(Name) :- take_so_many_centr_usel(Name).
% П10
waiting_time_40min(Name) :- take_so_local_controller(Name).
% П11
get_a_file(Name) :-waiting_time_30min(Name).


clauses
canuse("Dima"). % Ф1
canuse("Ivan"). % Ф1
canuse("San").% Ф1
have_cabel("Dima"). %Ф2
have_cabel("Ivan"). %Ф2
have_cabel("San").%Ф2
eco_to_shina("Dima"). % Ф3
eco_to_shina("Dima"). % Ф3
eco_to_shina("San").% Ф3
safe_to_star("Dima"). % Ф4
safe_to_star("Ivan").% Ф4
safe_to_star("San").% Ф4
gold_to_circle("Dima"). %Ф5
gold_to_circle("Ivan").%Ф5
gold_to_circle("San").%Ф5

a_lot_of_cabel("A lot of cabel"). % Ф6
have_centr_usel("CentrUsel"). % Ф7
have_net_control("NetControl"). % Ф8
chose_a_topologia("Dima"). % Ф9
chose_a_topologia("Ivan"). % Ф9
chose_a_topologia("San"). % Ф9

clauses
    run() :-
    console::nl,
    console::write(" -- get_a_file Dima? "),
    console::nl,
    foreach can_use_to_topology("Dima") do
        get_a_file("Dima"),!,console::write("Yes"); console::write("No")
    end foreach,
    console::nl, console::nl,
    console::write(" -- get_a_file Ivan? "),
    console::nl,
    foreach can_use_to_topology("Ivan") do
        get_a_file("Ivan"),!,console::write("Yes"); console::write("No")
    end foreach,
    console::nl,
    console::write(" -- get_a_file San? "),
    console::nl,
    foreach can_use_to_topology("San") do
        get_a_file("San"),!,console::write("Yes"); console::write("No")
    end foreach,
    console::nl,
    console::nl.

end implement main

goal
    console::runUtf8(main::run).
