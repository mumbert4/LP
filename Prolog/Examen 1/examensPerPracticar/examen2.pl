path([],_,_):- fail.
path(_, X,X):-!.
path(L,X,Y):- select([X,A],L,R),path(R, A, Y),!.




negate(\+X,X):-!.

negate(X,\+X).



sat(N,S):-

   findall( [B2,A]  , (member([A,B],S), negate(B,B2))     , G1 ),

   findall(  [A2,B]     ,  (member([A,B],S), negate(A,A2)) , G2 ),  append(G1,G2,G),

   \+badCycle(N,G).


badCycle(N,G):- between(1,N,X), negate(X,X2), path(G, X, X2), path(G, X2,X).
