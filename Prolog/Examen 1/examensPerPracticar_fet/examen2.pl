% select select (pert_con_resto) means "X is a
% member of the list L, and R is the list of remaining elements of L".
% select(X,L,R).

path([],_,_):- false,!.
path(_,B,B):-!.
path(L,A,B):- select([A,X],L,R), path(R,X,B).




negate(\+X,X):-!.
negate(X,\+X).



sat(N,S):-


   findall([X2,Y] ,(member([X,Y],S), negate(X,X2)) , G1 ),
   findall([Y2,X],(member([X,Y],S), negate(Y,Y2)) , G2 ), append(G1,G2,G),

   \+badCycle(N,G).





badCycle(N,G):- between(1,N,X), negate(X,X2), path(G,X,X2), path(G,X2,X).
