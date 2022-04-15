chosen(1).
chosen(5).
%%% input:
numMembersTeam(6).
numStudents(25).
% info( id, list_of_students_(s)he_considers_a_friend, topic )
info(1,[4,9,11,14,15,16,21,23,24],t6).
info(2,[4,9,12,15,16,19,23],t8).
info(3,[3,7,10,11,12,13,15,17,21,22,24],t3).
info(4,[1,7,8,13,15,23,24],t4).
info(5,[1,8,9,11,13,17,18,23,24],t6).
info(6,[1,2,3,5,6,8,9,16,18,20,22,23,24],t6).
info(7,[5,10,11,12,14,20,25],t3).
info(8,[4,9,12,20,21],t1).
info(9,[3,6,9,15,20,23,24],t8).
info(10,[2,4,5,7,8,10,11,13,15,16,21,24],t8).
info(11,[1,3,5,11,12,14,15,17,20,22,24],t2).
info(12,[3,6,8,10,11,12,14,15,17,18,22],t5).
info(13,[2,4,6,8,10,13,15,18,19,24,25],t4).
info(14,[2,8,11,12,19],t4).
info(15,[3,4,6,11,12,14,15,16,17,22],t6).
info(16,[1,3,4,5,7,10,14,18,22,25],t3).
info(17,[2,3,9,11,12,14,15,16,17,19,20,22],t4).
info(18,[4,5,7,10,11,14,17,18,20,24],t8).
info(19,[3,4,7,19,24],t4).
info(20,[1,2,3,6,11,13,19],t8).
info(21,[1,10,17,19,23,24,25],t8).
info(22,[3,4,11,12,13,15,16,17,20,22],t1).
info(23,[6,11,21,24],t4).
info(24,[2,6,12,13,15,18,19,20,21,23,25],t7).
info(25,[1,3,8,10,13,18,20,21,24],t3).

student(S):-     numStudents(N), between(1,N,S).
friends(S1,S2):- student(S1), student(S2), info(S1,L,_), member(S2,L).
expertise(S,E):- student(S), info(S,_,E).

amigosentrellos(S1, S2):- friends(S1, S2), !.
amigosentrellos(S1, S2):-write('Error '), write(S1), write(' no es amigo de '), write(S2), nl, !.

unicotema(S1, S2):-expertise(S1, E1), not(expertise(S2, E1)), !.
unicotema(S1, S2):-write('Error '), write(S1), write(' mismo tema que '), write(S2), nl, !.

checker():-chosen(S1), chosen(S2), noiguales(S1, S2), amigosentrellos(S1, S2), unicotema(S1, S2), fail.

noiguales(S1, S2):- S1 \= S2.
