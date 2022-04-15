cifras(L, N):- subcjto(L, S), permutacion(S, P), expresion(P, E),
               N is E, write(E), nl, fail.

expresion([X], X).
expresion(L, E1+E2):- append(L1, L2, L), L1\=[], L2\=[],
                      expresion(L1, E1), expresion(L2, E2).

expresion(L, E1-E2):- append(L1, L2, L), L1\=[], L2\=[],
                      expresion(L1, E1), expresion(L2, E2).

expresion(L, E1*E2):- append(L1, L2, L), L1\=[], L2\=[],
                      expresion(L1, E1), expresion(L2, E2).

expresion(L, E1//E2):- append(L1, L2, L), L1\=[], L2\=[],
                      expresion(L1, E1), expresion(L2, E2), K is E2, K\=0.

subcjto([], []).
subcjto([_|C], S):- subcjto(C, S).
subcjto([X|C], [X|S]):- subcjto(C, S).


permutacion([], []).
permutacion(L, [X|P]):- select(X, L, R), permutacion(R, P).
