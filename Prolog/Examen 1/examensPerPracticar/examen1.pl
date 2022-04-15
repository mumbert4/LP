chain([],[]).
chain([[X,Y]], [[X,Y]]).
chain([[X,Y]], [[Y,X]]).
chain([[X,Y]|L], [[X,Y]|R]):- chain(L,R), R = [[Y,_]|_].
chain([[X,Y]|L], [[Y,X]|R]):- chain(L,R), R = [[X,_]|_].



comb([],[]).
comb([_|L], R):- comb(L,R).
comb([X|L], [X|R]):- comb(L,R).

all_chains(L):-
    comb(L,R),
    permutation(R,P),
    chain(P,S), write(S),nl,nl,fail.

all_chains(_).
