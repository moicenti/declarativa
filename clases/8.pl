desea_conocer_v4(X, Y, W) :-
    desea_conocer_v4_rec(X, Y, [], L),
    append(L, [X], W).

desea_conocer_v4_rec(X, Y, L, [Y|L]) :- conoce(X, Y), !.

desea_conocer_v4_rec(X, L, L) :-
    conoce(X, Z),
    member(Z, L),
    fail.

desea_conocer_v4_rec(X, Y, L, Lfin) :-
    conoce(X, Z),
    not(member(Z, L)),
    desea_conocer_v4_rec(Z, Y, [Z|L], Lfin).


desea_conocer_v3(X, Y, W) :-
    desea_conocer_v3_rec(X, Y, [], L),
    append(L, [X], W).

desea_conocer_v3_rec(X, Y, L, Lfin) :-
    conoce(X, Y),
    Lfin = [Y|L],
    !.

desea_conocer_v3_rec(X, _, L, _) :-
    conoce(X, Z),
    member(Z, L),
    fail.

desea_conocer_v3_rec(X, Y, L, Lfin) :-
    conoce(X, Z),
    not(member(Z, L)),
    Ltemp = [Z|L],
    desea_conocer_v3_rec(Z, Y, Ltemp, LfinAux),
    Lfin = LfinAux.


desea_conocer_v2(X, Y) :-
    abolish(eslabon, 1),
    assert(eslabon(X)),
    desea_conocer_v2_rec(X, Y).

desea_conocer_v2_rec(X, Y) :-
    conoce(X, Y),
    assert(eslabon(Y)),
    !.

desea_conocer_v2_rec(X, _) :-
    conoce(X, Z),
    eslabon(Z),
    fail.

desea_conocer_v1(X, Y) :- conoce(X, Y), writeln(Y), !.
desea_conocer_v1(X, Y) :- conoce(X, Z), desea_conocer_v1(Z, Y), writeln(Z).


/*
grace.
consulta.
nograce.
nodebug.
 */

 /*clase 10
 
 atom/1	¿es átomo?	atom(h) → true
atomic/1	¿es átomo o número?	atomic(5) → true
number/1	¿es número?	number(3r4) → true
integer/1	¿es entero?	integer(5) → true
float/1	¿es flotante?	float(5.3) → true
rational/1	¿es racional?	rational(3r4) → true
var/1	¿es variable libre?	var(X) → true
nonvar/1	¿está ligada?	nonvar(5) → true
eval/1	fuerza evaluación	eval(R)

  */