
nat(0).
nat(N):- nat(N1), N is N1 + 1.

camino( E,E, C,C ).
    camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    unPaso( EstadoActual, EstSiguiente ),
    \+member(EstSiguiente,CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).


legal(MisIz, CanIz, MisDr, CanDr):-
  (MisIz >= CanIz; MisIz = 0), (MisDr >= CanDr; MisDr = 0),
  MisIz >= 0, MisIz < 4, CanIz >=0, CanIz < 4,
  MisDr >= 0, MisDr < 4, CanDr >=0, CanDr < 4.

unPaso([MisIz,CanIz,0,MisDr,CanDr], [MisIz2,CanIz2,1,MisDr2,CanDr2]):-
  MisIz2 is MisIz - 1,
  CanIz2 is CanIz,
  MisDr2 is MisDr + 1,
  CanDr2 is CanDr,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).

unPaso([MisIz,CanIz,0,MisDr,CanDr], [MisIz2,CanIz2,1,MisDr2,CanDr2]):-
  MisIz2 is MisIz - 2,
  CanIz2 is CanIz,
  MisDr2 is MisDr + 2,
  CanDr2 is CanDr,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).

unPaso([MisIz,CanIz,0,MisDr,CanDr], [MisIz2,CanIz2,1,MisDr2,CanDr2]):-
  MisIz2 is MisIz,
  CanIz2 is CanIz - 1,
  MisDr2 is MisDr,
  CanDr2 is CanDr + 1,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).

unPaso([MisIz,CanIz,0,MisDr,CanDr], [MisIz2,CanIz2,1,MisDr2,CanDr2]):-
  MisIz2 is MisIz,
  CanIz2 is CanIz - 2,
  MisDr2 is MisDr,
  CanDr2 is CanDr + 2,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).

unPaso([MisIz,CanIz,0,MisDr,CanDr], [MisIz2,CanIz2,1,MisDr2,CanDr2]):-
  MisIz2 is MisIz - 1,
  CanIz2 is CanIz - 1,
  MisDr2 is MisDr + 1,
  CanDr2 is CanDr + 1,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).



unPaso([MisIz,CanIz,1,MisDr,CanDr], [MisIz2,CanIz2,0,MisDr2,CanDr2]):-
  MisIz2 is MisIz + 1,
  CanIz2 is CanIz,
  MisDr2 is MisDr - 1,
  CanDr2 is CanDr,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).

unPaso([MisIz,CanIz,1,MisDr,CanDr], [MisIz2,CanIz2,0,MisDr2,CanDr2]):-
  MisIz2 is MisIz + 2,
  CanIz2 is CanIz,
  MisDr2 is MisDr - 2,
  CanDr2 is CanDr,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).

unPaso([MisIz,CanIz,1,MisDr,CanDr], [MisIz2,CanIz2,0,MisDr2,CanDr2]):-
  MisIz2 is MisIz,
  CanIz2 is CanIz + 1,
  MisDr2 is MisDr,
  CanDr2 is CanDr - 1,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).

unPaso([MisIz,CanIz,1,MisDr,CanDr], [MisIz2,CanIz2,0,MisDr2,CanDr2]):-
  MisIz2 is MisIz,
  CanIz2 is CanIz + 2,
  MisDr2 is MisDr,
  CanDr2 is CanDr - 2,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).

unPaso([MisIz,CanIz,1,MisDr,CanDr], [MisIz2,CanIz2,0,MisDr2,CanDr2]):-
  MisIz2 is MisIz + 1,
  CanIz2 is CanIz + 1,
  MisDr2 is MisDr - 1,
  CanDr2 is CanDr - 1,
  legal(MisIz2, CanIz2, MisDr2, CanDr2).


solucionOptima:-
  nat(N),
  camino([3,3,0,0,0], [0,0,1,3,3], [[3,3,0,0,0]] , C),
  length(C,N),
  reverse(C,R),
  write(R).
