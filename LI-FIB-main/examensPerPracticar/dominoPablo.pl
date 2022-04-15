chain([], []).
chain([[X, Y]], [[X, Y]]).
chain([[X, Y]], [[Y, X]]).
chain([[X, Y]|L1], [[X, Y]|L2]):-chain(L1, L2), L2 = [[Y, _]|_].
chain([[X, Y]|L1], [[Y, X]|L2]):-chain(L1, L2), L2 = [[X, _]|_].

grupos([], []).
grupos([_|L], S):- grupos(L, S).
grupos([X|L], [X|S]):- grupos(L, S).

all_chains(L):-
  grupos(L, S),
  permutation(S, P),
  chain(P, R),
  write(R), nl, fail.
all_chains(_).
