suma_hasta_1(1, 1).

suma_hasta_1(N, R) :-
    N > 1,
    A is N - 1,
    suma_hasta_1(A, Sa),
    R is N + Sa.
