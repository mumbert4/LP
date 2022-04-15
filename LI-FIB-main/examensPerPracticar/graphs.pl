path(_, N, N):- !.
path(G, V1, V2):- select([V1, V3], G, L), path(L,  V3, V2),!.

negate(\+X,X):-!.
negate(X,\+X).

sat(N,S):-
   findall([A, Y], (member([X, Y], S), negate(X, A)), G1),
   findall([A, X], (member([X, Y], S), negate(Y, A)), G2),  append(G1,G2,G),
   \+badCycle(N,G).


badCycle(N,G):- between(1, N, X), negate(X, NX), path(G, X, NX), path(G, NX, X).
