

%regla 1, se necesita alguien con objeto que pueda talar y alguien que cargue troncos
recolectar_troncos(X,Y) :-
	objeto(X,Q),
	propiedad_objeto(Q,talar),
	puede(Y,cargar_troncos);
	objeto(Y,Q),
	propiedad_objeto(Q,talar),
	puede(X,cargar_troncos).
	
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
