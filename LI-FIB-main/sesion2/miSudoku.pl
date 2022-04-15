%Ejercicio 1
prod([X], X).
prod([X|L], P):- prod(L, P1), P is X*P1.

%Ejercicio 2
pescalar([], [], 0).
pescalar([X|L1], [Y|L2], P):- pescalar(L1, L2, P1), P is P1 + X*Y.

%Ejercicio 3

%Ejercicio 4

%Ejercicio 5
fib(1, 1).
fib(2, 1).
fib(N, F):- N > 2, N1 is N - 1, N2 is N - 2,fib(N1, F1), fib(N2, F2), F is F1 + F2.

%Ejercicio 6
dados(0, 0, []).
dados(P, N, [X|L]):- N > 0, member(X, [1, 2, 3, 4, 5, 6]), N1 is N - 1, P1 is P - X, dados(P1, N1, L).

%Ejercicio 7
sum([], 0).
sum([X|L], R):-sum(L, R1), R is R1 + X.

suma_demas(L):- append(L1, [X|L2], L), append(L1, L2, NL), sum(NL, X).

%Ejercicio 8
suma_ants(L):- append(L1, [X|_], L), sum(L1, X).

%Ejercicio 9

%Dados
dadosDeColores:- R = [R1, R2, R3],
                 V = [V1, V2, V3],
                 A = [A1, A2, A3],
                 permutation([R1, R2, R3, V1, V2, V3, A1, A2, A3],
                             [1, 2, 3, 4, 5, 6, 7, 8, 9]),
                 gana(R, V),
                 gana(V, A),
                 gana(A, R),
                 write(R-V-A), nl, halt.

gana(D1, D2):- findall([X, Y], (member(X, D1), member(Y, D2), X>Y), L),
               length(L, K), K >= 5.
