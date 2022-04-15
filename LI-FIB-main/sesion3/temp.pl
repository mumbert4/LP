sameParity(I1, I2):- (0 is I1 mod 2), (0 is I2 mod 2), !.
sameParity(I1, I2):- not(0 is I1 mod 2), not(0 is I2 mod 2), !.


mayorQue20(C):- C =< 10, !.
mayorQue20(C):- write('Error, el coste '), write(C), write(' es mayor que 10.'), nl, !.
