almacenar(0, []).

almacenar(N,[A|L]) :-
    A is N mod 10,
    R is N div 10,
    almacenar(R,L).