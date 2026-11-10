arbolPrueba([ [[[[],10,[]],20,[]],30,[[],40,[]]],
              50,
              [[[],60,[]],70,[[],90,[]]] ]).


sumaTotal([],0).
sumaTotal([I,X,D],N):-
    sumaTotal(I,NI),
    sumaTotal(D,ND),
    is(N,+(+(X+NI),ND)).

caminoMaximo([],0).
caminoMaximo([I,X,D], N) :-
    caminoMaximo(I,NI),
    caminoMaximo(D,ND),
    is(N, +(X,max(NI,(ND)))).