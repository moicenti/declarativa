

%No me funes por usar operador de corte ya lo explicaron en clase y me da cosa tener que darle ;
% para ver un false siempre porque eric tiene dos objetos :(
%regla 1, se necesita alguien con objeto que pueda talar y alguien que cargue troncos
recolectar_troncos(X,Y,Z) :-
	objeto(X,Q),
	propiedad_objeto(Q,talar),
	puede(Y,cargar_troncos),
	contiene(Z,tronco);
	objeto(Y,Q),
	propiedad_objeto(Q,talar),
	puede(X,cargar_troncos),
	contiene(Z,tronco),!.
	
%regla 2, para pelear se necesita algo con que atacar y un enemigo

pelear(X,Y) :-
	objeto(X,Q),
	propiedad_objeto(Q,atacar),
	enemigo(Y).

%necesitas luz y llave
abrir_bunker(X) :-
	objeto(X,Q),
	propiedad_objeto(Q,abrir),
	objeto(X,H),
	propiedad_objeto(H,luz).
