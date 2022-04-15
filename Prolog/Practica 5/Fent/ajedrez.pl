
size(8).
numPasos(5).


camino( E,E, C,C ).
    camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
    unPaso( EstadoActual, EstSiguiente ),
    \+member(EstSiguiente,CaminoHastaAhora),
    camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).











solucionOptima:-
  nat(N),
  camino([1,1], [2,3], [] , C),
  length(C,N),
  reverse(C,R),
  write(R).
