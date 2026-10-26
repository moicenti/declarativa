:- dynamic evalDFx/2.

% Casos base
d(_, K, 0) :- number(K), !.
d(X, X^N, N*X^E) :- number(N), is(E, -(N,1)), !.
d(X, Y, 1) :- var(Y), Y = X, !.
d(X, K*X^N, (K*N)*X^E) :- number(K), number(N), is(E, -(N,1)), !.
d(X, K*X, K) :- number(K), !.
d(X, log(X), 1/X) :- !.
d(X, exp(X), exp(X)) :- !.
d(X, A^X, A^X * log(A)) :- number(A), !.
d(X, sin(X), cos(X)) :- !.
d(X, cos(X), -sin(X)) :- !.
d(X, tan(X), 1/(cos(X)^2)) :- !.
d(X, sqrt(X), 1/(2*sqrt(X))) :- !.
d(X, 1/X, -1/X^2) :- !.

% Recursivos (sin cadena)
d(X, F + G, RF + RG) :- d(X, F, RF), d(X, G, RG), !.
d(X, F - G, RF - RG) :- d(X, F, RF), d(X, G, RG), !.
d(X, K*F, K*RF) :- number(K), d(X, F, RF), !.
d(X, F * G, RF*G + F*RG) :- d(X, F, RF), d(X, G, RG), !.
d(X, F / G, (RF*G - F*RG) / G^2) :- d(X, F, RF), d(X, G, RG), !.

% Grabar y evaluar
grabarDerivada(Funcion) :-
    abolish(evalDFx, 2),
    d(X, Funcion, R),
    asserta((evalDFx(X, W) :- is(W, eval(R)))).

evalDerivada(Funcion, X, Valor) :-
    grabarDerivada(Funcion),
    evalDFx(X, Valor).