maxCost(10).
numCities(20).

adjacency(1,[10]).
adjacency(2,[7,5,17]).  % Three one-way roads from city 2:  2->7, 2->5 and 2->17.
adjacency(3,[6,20,11]).
adjacency(4,[14,15,1,8,5]).
adjacency(5,[16,4,9,10,11]).
adjacency(6,[1,13,17]).
adjacency(7,[16,9,13,11]).
adjacency(8,[7,3,10,6,17]).
adjacency(9,[6,17,11]).
adjacency(10,[7,11,5,6,4]).
adjacency(11,[20,8,15,4,1,16,3]).
adjacency(12,[15,11,3]).
adjacency(13,[5,2,19,3,6]).
adjacency(14,[10,12,9,7]).
adjacency(15,[20,1,14,18,12,2]).
adjacency(16,[7,6,4,8,2,10]).
adjacency(17,[20,5,16,3,8]).
adjacency(18,[15,16,7,14,3]).
adjacency(19,[13,6]).
adjacency(20,[12,6,18,7,16]).

visited(1,0).
visited(10,1).
visited(11,2).
visited(4,3).
visited(5,4).
visited(9,5).
visited(17,6).
visited(16,7).
visited(8,8).
visited(3,9).
visited(20,10).
visited(18,11).
visited(14,12).
visited(12,13).
visited(15,14).
visited(2,15).
visited(7,16).
visited(13,17).
visited(19,18).
visited(6,19).
visited(1,20).

sameParity(I1, I2):- (0 is I1 mod 2), (0 is I2 mod 2), !.
sameParity(I1, I2):- not(0 is I1 mod 2), not(0 is I2 mod 2), !.

position(P):- numCities(N), between(0,N,P).
city(I):-     adjacency(I,_).

sonAdyacentes(I1, I2):- adjacency(I1, L), member(I2, L), !.
sonAdyacentes(I1, I2):- write('Error: la ciudad '), write(I1), write(' no es adyacente a '), write(I2), nl, !.

coste(20, 0):- !.
coste(P1, C):- P2 is P1 + 1, visited(I1, P1), visited(I2, P2), sameParity(I1, I2), coste(P2, C1), !, C is C1 + 0.
coste(P1, C):- P2 is P1 + 1, coste(P2, C1), !, C is C1 + 1.

mayorQue10(C):- C =< 10, !.
mayorQue10(C):- write('Error, el coste '), write(C), write(' es mayor que 10.'), nl, !.

check():- coste(0, C), mayorQue10(C), position(P1), not(position(P1) = position(20)), P2 is P1 + 1, visited(I1, P1), visited(I2, P2), not(city(I1) = city(I2)), sonAdyacentes(I1, I2), fail.
