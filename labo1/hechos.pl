%para suprimir warinings
:- discontiguous tipo/2.
:- discontiguous objeto/2.
:- discontiguous dificultad/3.
:- discontiguous encuentras/2.

%Eric y lo que tiene/hace/necesita
tipo(eric,protagonista).
edad(eric,30).
objeto(eric,hacha).
objeto(eric,encendedor).
necesidad(eric,refugio).
necesidad(eric,comida).
necesidad(eric,agua).
%para probar el bunker
%objeto(eric,llave).


%Kelvin

tipo(kelvin,aliado).
mudo(kelvin).
puede(kelvin,cargar_troncos).
puede(kelvin,construir).
%Timmy no hace nada 


%Virginia
tipo(virginia,mutante).
puede_ser_aliado(virginia).
objeto(virginia,puno).

%van los objetos
propiedad_objeto(hacha,atacar).
propiedad_objeto(puno,atacar).
propiedad_objeto(hacha,talar).
propiedad_objeto(encendedor,luz).
propiedad_objeto(llave,abrir).

%zonas

contiene(superficie,tronco).
contiene(superficie,piedra).
dificultad(superficie,medio,dia).
encuentras(superficie,mutante).
dificultad(superficie,alta,noche).
enceuntras(superficie,canibal).

dificultad(caverna,alta).
encuentras(caverna,mutante).

requiere(bunker,llave).

%enemigos
enemigo(canibal).
enemigo(mutante).
