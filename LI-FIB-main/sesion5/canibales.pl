nat(0).
nat(N) :- nat(N1), N is N1 + 1.

camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
  unPaso( EstadoActual, EstSiguiente ),
  \+member(EstSiguiente,CaminoHastaAhora),
  camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).

solucionOptima:-
  nat(N),
  camino([3, 3, true, 0, 0], [0, 0, false, 3, 3], [3, 3, true, 0, 0], C),
  length(C,N),
  write(C-N), !.


legal([C, M, _, C2, M2]):-
  C >= 0, M >= 0, C2 >= 0, M2 >= 0,
  (C =< M; M = 0),
  (C2 =< M2; M2 = 0).

%se van un explorer true
unPaso([CanibalesIzq, ExplorersIzq, true, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq,
  ExplorersIzqN is ExplorersIzq -1,
  CanibalesDerN is CanibalesDer,
  ExplorersDerN is ExplorersDer + 1,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]).

%se van un explorer false
unPaso([CanibalesIzq, ExplorersIzq, false, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq,
  ExplorersIzqN is ExplorersIzq + 1,
  CanibalesDerN is CanibalesDer,
  ExplorersDerN is ExplorersDer - 1,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]).

%se van un canibal true
unPaso([CanibalesIzq, ExplorersIzq, true, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq - 1,
  ExplorersIzqN is ExplorersIzq,
  CanibalesDerN is CanibalesDer + 1,
  ExplorersDerN is ExplorersDer,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]).

%se van un canibal false
unPaso([CanibalesIzq, ExplorersIzq, false, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq + 1,
  ExplorersIzqN is ExplorersIzq,
  CanibalesDerN is CanibalesDer - 1,
  ExplorersDerN is ExplorersDer,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]).

%se van 2 explorer true
unPaso([CanibalesIzq, ExplorersIzq, true, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq,
  ExplorersIzqN is ExplorersIzq -2,
  CanibalesDerN is CanibalesDer,
  ExplorersDerN is ExplorersDer + 2,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]).

%se van 2 explorer false
unPaso([CanibalesIzq, ExplorersIzq, false, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq,
  ExplorersIzqN is ExplorersIzq + 2,
  CanibalesDerN is CanibalesDer,
  ExplorersDerN is ExplorersDer - 2,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]).

%se van 2 canibal true
unPaso([CanibalesIzq, ExplorersIzq, true, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq - 2,
  ExplorersIzqN is ExplorersIzq,
  CanibalesDerN is CanibalesDer + 2,
  ExplorersDerN is ExplorersDer,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]).

%se van 2 canibal false
unPaso([CanibalesIzq, ExplorersIzq, false, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq + 2,
  ExplorersIzqN is ExplorersIzq,
  CanibalesDerN is CanibalesDer - 2,
  ExplorersDerN is ExplorersDer,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]).

%se van 1 de cada true
unPaso([CanibalesIzq, ExplorersIzq, true, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq - 1,
  ExplorersIzqN is ExplorersIzq - 1,
  CanibalesDerN is CanibalesDer + 1,
  ExplorersDerN is ExplorersDer + 1,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, false, CanibalesDerN, ExplorersDerN]).

%se van 1 de cada false
unPaso([CanibalesIzq, ExplorersIzq, false, CanibalesDer, ExplorersDer], [CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]):-
  CanibalesIzqN is CanibalesIzq + 1,
  ExplorersIzqN is ExplorersIzq + 1,
  CanibalesDerN is CanibalesDer - 1,
  ExplorersDerN is ExplorersDer - 1,
  %write(CanibalesIzq-ExplorersIzq-CanibalesDer-ExplorersDer), nl,
  legal([CanibalesIzqN, ExplorersIzqN, true, CanibalesDerN, ExplorersDerN]).
