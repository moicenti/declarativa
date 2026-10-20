s(Var, N, N*Var):-
    atomic(Var), number(N), !.

s(Var, Var, 1/2*Var^2):- 
    atomic(Var), !.

s(Var,K*Var, K/2*Var^2) :-
    atomic(Var), number(K), !.


% Kx^n
s(Var, K*Var^N, K/C*Var^C) :-
    atomic(Var), number(N), number(K), is(C, +(N,1)), !.

s(Var, sin(Var), -cos(Var)):-
    atomic(Var),!.

d(2)