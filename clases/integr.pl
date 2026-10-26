% =====================================================
% INTEGRALES SIMBÓLICAS EVALUABLES
% Mecanismo: abolish + asserta + evall/2 + eval
% Variable simbólica: X (mayúscula, para poder ligarla)
% Funciones nativas de Prolog: sin, cos, tan, log, exp, sqrt
% =====================================================

:- dynamic evall/2.

% ---------- CASOS BASE -------------------------------
% ORDEN IMPORTANTE: los más específicos van primero.

% 1. Integral de una constante: ∫ k dX = k*X
s(X, K, K*X) :- number(K), !.

% 2. Integral de X^N: ∫ X^N dX = (1/(N+1))*X^(N+1)
%    Se evalúa N+1 para simplificar el exponente.
s(X, X^N, (1/E)*X^E) :-
    number(N),
    is(E, +(N, 1)), !.

% 3. Integral de X respecto a X: ∫ X dX = (1/2)*X^2
%    Usamos var(Y) para asegurar que el segundo argumento sea
%    una variable libre (no X^3, sqrt(X), etc.)
s(X, Y, (1/2)*X^2) :- var(Y), Y = X, !.

% 4. Integral de k*X^N: ∫ k*X^N dX = (k/(N+1))*X^(N+1)
%    Se evalúa N+1 para simplificar el exponente.
s(X, K*X^N, (K/E)*X^E) :-
    number(K), number(N),
    is(E, +(N, 1)), !.

% 5. Integral de k*X: ∫ k*X dX = (k/2)*X^2
s(X, K*X, (K/2)*X^2) :- number(K), !.

% 6. Integral de 1/X: ∫ (1/X) dX = log(X)
s(X, 1/X, log(X)) :- !.

% 7. Integral de exp(X): ∫ exp(X) dX = exp(X)
s(X, exp(X), exp(X)) :- !.

% 8. Integral de a^X: ∫ a^X dX = a^X / log(a)
s(X, A^X, (A^X)/log(A)) :- number(A), !.

% 9. Integral de sin(X): ∫ sin(X) dX = -cos(X)
s(X, sin(X), -cos(X)) :- !.

% 10. Integral de cos(X): ∫ cos(X) dX = sin(X)
s(X, cos(X), sin(X)) :- !.

% 11. Integral de tan(X): ∫ tan(X) dX = -log(cos(X))
s(X, tan(X), -log(cos(X))) :- !.

% 12. Integral de log(X): ∫ log(X) dX = X*log(X) - X
s(X, log(X), X*log(X) - X) :- !.

% 13. Integral de sqrt(X): ∫ sqrt(X) dX = (2/3)*X^(3/2)
s(X, sqrt(X), (2/3)*X^(3/2)) :- !.

% 14. Integral de X^(-2): ∫ X^(-2) dX = -1/X
s(X, X^(-2), -1/X) :- !.

% ---------- CASOS RECURSIVOS -------------------------

% 15. Integral de una suma: ∫ (f + g) dX = ∫f + ∫g
s(X, F + G, RF + RG) :-
    s(X, F, RF),
    s(X, G, RG), !.

% 16. Integral de una resta: ∫ (f - g) dX = ∫f - ∫g
s(X, F - G, RF - RG) :-
    s(X, F, RF),
    s(X, G, RG), !.

% 17. Integral de k*f(X): ∫ k*f(X) dX = k * ∫f(X) dX
s(X, K*F, K*RF) :-
    number(K),
    s(X, F, RF), !.

% ---------- GRABAR Y EVALUAR -------------------------

% Grabar la integral como regla evall/2
grabarIntegral(Funcion) :-
    abolish(evall, 2),
    s(X, Funcion, R),
    asserta((evall(X, W) :- is(W, eval(R)))).

% Calcular el área bajo la curva entre A y B
areaBajoCurva(Funcion, A, B, Area) :-
    grabarIntegral(Funcion),
    evall(B, ELs),
    evall(A, ELi),
    is(Area, -(ELs, ELi)).