% =====================================================
% ÁRBOL: [SubArbolIzq, Dato, SubArbolDer]   |  Vacío: []
% =====================================================

% ---------- ÁRBOL DE PRUEBA --------------------------
%
%               50
%              /  \
%            30    70
%           / \    / \
%         20  40  60  80
%         /           \
%       10             90
%
arbolPrueba([ [[[[],10,[]],20,[]],30,[[],40,[]]],
              50,
              [[[],60,[]],70,[[],90,[]]] ]).

% ---------- CONSTRUCCIÓN -----------------------------

insertar([], X, [[], X, []]).

insertar([I,R,D], X, [I,R,D]) :- X =:= R, !.

insertar([I,R,D], X, [NI,R,D]) :-
    X < R, !,
    insertar(I, X, NI).

insertar([I,R,D], X, [I,R,ND]) :-
    X > R, !,
    insertar(D, X, ND).

construir(L, A) :- construirAux(L, [], A).

construirAux([], A, A).
construirAux([X|Xs], A0, A) :-
    insertar(A0, X, A1),
    construirAux(Xs, A1, A).

% ---------- RECORRIDOS (devuelven lista) -------------

preordenL([], []).
preordenL([I,R,D], [R|L]) :-
    preordenL(I, LI),
    preordenL(D, LD),
    append(LI, LD, L2),
    append([R|L2], [], L).      % simplemente [R|L2], pero así queda claro

% Versión más limpia:
preordenL2([], []).
preordenL2([I,R,D], L) :-
    preordenL2(I, LI),
    preordenL2(D, LD),
    append(LI, LD, LR),
    L = [R|LR].

inordenL([], []).
inordenL([I,R,D], L) :-
    inordenL(I, LI),
    inordenL(D, LD),
    append(LI, [R|LD], L).

postordenL([], []).
postordenL([I,R,D], L) :-
    postordenL(I, LI),
    postordenL(D, LD),
    append(LI, LD, LR),
    append(LR, [R], L).

% ---------- BÚSQUEDA EN ABB --------------------------

buscarABB(_, [], no).
buscarABB(X, [_,X,_], si) :- !.
buscarABB(X, [I,R,_], Rta) :- X < R, !, buscarABB(X, I, Rta).
buscarABB(X, [_,R,D], Rta) :- X > R, !, buscarABB(X, D, Rta).

% ---------- ALTURA -----------------------------------

altura([], 0).
altura([I,_,D], H) :-
    altura(I, HI),
    altura(D, HD),
    H is 1 + max(HI, HD).

% ---------- CONTAR NODOS -----------------------------

contar([], 0).
contar([I,_,D], N) :-
    contar(I, NI),
    contar(D, ND),
    N is 1 + NI + ND.

% ---------- CONTAR HOJAS -----------------------------

contarHojas([], 0).
contarHojas([[],_,[]], 1) :- !.
contarHojas([I,_,D], N) :-
    contarHojas(I, NI),
    contarHojas(D, ND),
    N is NI + ND.

% ---------- MÍNIMO Y MÁXIMO --------------------------

minimo([[],R,_], R) :- !.
minimo([I,_,_], M)  :- minimo(I, M).

maximo([_,R,[]], R) :- !.
maximo([_,_,D], M)  :- maximo(D, M).

% ---------- SUMA DE NODOS ----------------------------

sumar([], 0).
sumar([I,R,D], S) :-
    sumar(I, SI),
    sumar(D, SD),
    S is R + SI + SD.

% ---------- LISTAR HOJAS -----------------------------

hojas([], []).
hojas([[],R,[]], [R]) :- !.
hojas([I,_,D], L) :-
    hojas(I, LI),
    hojas(D, LD),
    append(LI, LD, L).

% ---------- ESPEJO -----------------------------------

espejo([], []).
espejo([I,R,D], [DI,R,II]) :-
    espejo(I, II),
    espejo(D, DI).

% ---------- ¿ES ABB? ---------------------------------

esABB(A) :- inordenL(A, L), ordenada(L).

ordenada([]).
ordenada([_]).
ordenada([A,B|R]) :- A =< B, ordenada([B|R]).

% ---------- ELIMINAR UN NODO -------------------------

eliminar([], _, []).
eliminar([I,R,D], X, [NI,R,D]) :- X < R, !, eliminar(I, X, NI).
eliminar([I,R,D], X, [I,R,ND]) :- X > R, !, eliminar(D, X, ND).
eliminar([[],_,D], _, D) :- !.
eliminar([I,_,[]], _, I) :- !.
eliminar([I,_,D], _, [I,M,ND]) :-
    minimo(D, M),
    eliminar(D, M, ND).

% ---------- MENORES/MATYORES QUE N -------------------

menoresMayores(_, [], [0,0]).
menoresMayores(N, [I,R,D], [C1,C2]) :-
    menoresMayores(N, I, [CI1,CI2]),
    menoresMayores(N, D, [CD1,CD2]),
    ( R =< N ->
        C1 is CI1+CD1+1, C2 is CI2+CD2
    ;
        C1 is CI1+CD1, C2 is CI2+CD2+1
    ).


/*
A = [[[[[], 10, []], 20, []], 30, [[], 40, []]], 50, [[[], 60, []], 70, [[], 90, []]]].
 */

 