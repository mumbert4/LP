chosen(1).
chosen(2).
chosen(3).
chosen(4).

info(1, [  5,    8,9,10,11,   13,14,15], baix).
info(2, [  2,      6,7,8,9,   11,12,13,   15], dalt).
info(3, [  2,  4,5,    8,  10,11,12,   14   ], baix).
info(4, [    3,    6,7,  9,10,11,   13,14,15], rasa).
info(5, [1,2,  4,5,  7,8,9   ,11,12         ], baix).
info(6, [1,  3,4,  6               ,13,14,15], viny).
info(7, [1,2,3,4,5,  7,8,9,10,   12,   14   ], rasa).
info(8, [1,        6,    9,10,11,   13      ], dalt).
info(9, [1,2,3,  5,  7,8,     11,12,13,14,15], baix).
info(10,[1,2,3,4,5,6,7,8,9,10,   12,      15], rasa).
info(11,[1,    4,  6,7,  9,10,11,   13,14   ], dalt).
info(12,[  2,    5,    8,9,      12,      15], viny).
info(13,[1,  3,  5,6,7,  9,10,11,12,13,14,15], viny).
info(14,[    3,      7,8,  10,   12   ,14   ], dalt).
info(15,[1,2,3,  5,6,  8,9,10,11,12,   14,15], rasa).

existe(L):- member(X, L), chosen(X), true, !.
existe(_):- write('Hay un problema'), nl, !.

check:- info(_, L, _), existe(L), fail.
