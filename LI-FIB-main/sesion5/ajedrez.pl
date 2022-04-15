casillasTablero(8).
pasos(1).

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
  unPaso( EstadoActual, EstSiguiente ),
  \+member(EstSiguiente,CaminoHastaAhora),
  camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
  pasos(N),
  camino([1, 1, 0], [3, 3, N], [1, 1, 0], _),
  write("Good Job"), !.

legal([FilaFinal, ColumnaFinal, NPasos]):-
  pasos(X),
  casillasTablero(N),
  0 < FilaFinal,
  FilaFinal =< N,
  0 < ColumnaFinal,
  ColumnaFinal =< N,
  NPasos =< X.


unPaso([FilaInicial, ColumnaInicial, Pasos], [FilaFinal, ColumnaFinal, NPasos]):-
  FilaFinal is FilaInicial - 1,
  ColumnaFinal is ColumnaInicial + 2,
  NPasos is Pasos + 1,
  legal([FilaFinal, ColumnaFinal, NPasos]),
  write(FilaFinal-ColumnaFinal-NPasos), nl.

unPaso([FilaInicial, ColumnaInicial, Pasos], [FilaFinal, ColumnaFinal, NPasos]):-
  FilaFinal is FilaInicial + 1,
  ColumnaFinal is ColumnaInicial + 2,
  NPasos is Pasos + 1,
  legal([FilaFinal, ColumnaFinal, NPasos]),
  write(FilaFinal-ColumnaFinal-NPasos), nl.

unPaso([FilaInicial, ColumnaInicial, Pasos], [FilaFinal, ColumnaFinal, NPasos]):-
  FilaFinal is FilaInicial + 2,
  ColumnaFinal is ColumnaInicial + 1,
  NPasos is Pasos + 1,
  legal([FilaFinal, ColumnaFinal, NPasos]),
  write(FilaFinal-ColumnaFinal-NPasos), nl.

unPaso([FilaInicial, ColumnaInicial, Pasos], [FilaFinal, ColumnaFinal, NPasos]):-
  FilaFinal is FilaInicial + 2,
  ColumnaFinal is ColumnaInicial - 1,
  NPasos is Pasos + 1,
  legal([FilaFinal, ColumnaFinal, NPasos]),
  write(FilaFinal-ColumnaFinal-NPasos), nl.

unPaso([FilaInicial, ColumnaInicial, Pasos], [FilaFinal, ColumnaFinal, NPasos]):-
  FilaFinal is FilaInicial + 1,
  ColumnaFinal is ColumnaInicial - 2,
  NPasos is Pasos + 1,
  legal([FilaFinal, ColumnaFinal, NPasos]),
  write(FilaFinal-ColumnaFinal-NPasos), nl.

unPaso([FilaInicial, ColumnaInicial, Pasos], [FilaFinal, ColumnaFinal, NPasos]):-
  FilaFinal is FilaInicial - 1,
  ColumnaFinal is ColumnaInicial - 2,
  NPasos is Pasos + 1,
  legal([FilaFinal, ColumnaFinal, NPasos]),
  write(FilaFinal-ColumnaFinal-NPasos), nl.

unPaso([FilaInicial, ColumnaInicial, Pasos], [FilaFinal, ColumnaFinal, NPasos]):-
  FilaFinal is FilaInicial - 2,
  ColumnaFinal is ColumnaInicial - 1,
  NPasos is Pasos + 1,
  legal([FilaFinal, ColumnaFinal, NPasos]),
  write(FilaFinal-ColumnaFinal-NPasos), nl.

unPaso([FilaInicial, ColumnaInicial, Pasos], [FilaFinal, ColumnaFinal, NPasos]):-
  FilaFinal is FilaInicial - 2,
  ColumnaFinal is ColumnaInicial + 1,
  NPasos is Pasos + 1,
  legal([FilaFinal, ColumnaFinal, NPasos]),
  write(FilaFinal-ColumnaFinal-NPasos), nl.
