



legal(X,Y):-
  size(S),
  X >=0, X < S,
  Y >=0, Y < S.



unPaso([X1,Y1],[X2,Y2]):-
  X2 is X1 + 1,
  Y2 is Y1 + 2,
  legal(X2,Y2).

unPaso([X1,Y1],[X2,Y2]):-
  X2 is X1 + 2,
  Y2 is Y1 + 1,
  legal(X2,Y2).


unPaso([X1,Y1],[X2,Y2]):-
  X2 is X1 + 2,
  Y2 is Y1 - 1,
  legal(X2,Y2).


unPaso([X1,Y1],[X2,Y2]):-
  X2 is X1 + 1,
  Y2 is Y1 - 2,
  legal(X2,Y2).


unPaso([X1,Y1],[X2,Y2]):-
  X2 is X1 - 1,
  Y2 is Y1 - 2,
  legal(X2,Y2).


unPaso([X1,Y1],[X2,Y2]):-
  X2 is X1 - 2,
  Y2 is Y1 - 1,
  legal(X2,Y2).


unPaso([X1,Y1],[X2,Y2]):-
  X2 is X1 - 2,
  Y2 is Y1 + 1,
  legal(X2,Y2).



camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
        length(CaminoHastaAhora,L), pasos(N), L =<N,
        unPaso( EstadoActual, EstSiguiente ),
        \+member(EstSiguiente,CaminoHastaAhora),
        camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

size(8).
pasos(8).

solucionOptima:-
    pasos(N),
    write("Comencam"),nl,
    camino([0,0], [7,7], [[0,0]] , C),
    N1 is N + 1,
    length(C,N1),
    write(C),!.
