nat(0).
nat(N) :- nat(N1), N is N1 + 1.


legal(MisIZ, CanIZ, MisIDR, CanDR):-
  (MisIZ >= CanIZ; MisIZ = 0), (MisIDR >= CanDR; MisIDR = 0),
   MisIZ>=0, MisIZ < 4, MisIDR >=0, MisIDR < 4,
   CanIZ>=0, CanIZ < 4, CanDR >=0, CanDR < 4.


%0 -> 1
% viaja un solo misionero
unPaso([MisIZ, CanIZ, 0, MisIDR, CanDR], [MisIZ2, CanIZ2, 1, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ -1,
  CanIZ2 is CanIZ,
  MisIDR2 is MisIDR + 1,
  CanDR2 is CanDR,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).


% viajan 2 misioneros
unPaso([MisIZ, CanIZ, 0, MisIDR, CanDR], [MisIZ2, CanIZ2, 1, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ -2,
  CanIZ2 is CanIZ,
  MisIDR2 is MisIDR + 2,
  CanDR2 is CanDR,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).

% viaja un solo canibal
unPaso([MisIZ, CanIZ, 0, MisIDR, CanDR], [MisIZ2, CanIZ2, 1, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ ,
  CanIZ2 is CanIZ -1,
  MisIDR2 is MisIDR,
  CanDR2 is CanDR +1,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).

% viajan 2 canibales
unPaso([MisIZ, CanIZ, 0, MisIDR, CanDR], [MisIZ2, CanIZ2, 1, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ,
  CanIZ2 is CanIZ -2,
  MisIDR2 is MisIDR,
  CanDR2 is CanDR +2,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).

% viajan 1 de cada
unPaso([MisIZ, CanIZ, 0, MisIDR, CanDR], [MisIZ2, CanIZ2, 1, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ -1,
  CanIZ2 is CanIZ -1,
  MisIDR2 is MisIDR +1,
  CanDR2 is CanDR +1,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).


% 1-> 0
% viaja un solo misionero
unPaso([MisIZ, CanIZ, 1, MisIDR, CanDR], [MisIZ2, CanIZ2, 0, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ +1,
  CanIZ2 is CanIZ,
  MisIDR2 is MisIDR - 1,
  CanDR2 is CanDR,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).


% viajan 2 misioneros
unPaso([MisIZ, CanIZ, 1, MisIDR, CanDR], [MisIZ2, CanIZ2, 0, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ +2,
  CanIZ2 is CanIZ,
  MisIDR2 is MisIDR - 2,
  CanDR2 is CanDR,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).

% viaja un solo canibal
unPaso([MisIZ, CanIZ, 1, MisIDR, CanDR], [MisIZ2, CanIZ2, 0, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ ,
  CanIZ2 is CanIZ +1,
  MisIDR2 is MisIDR,
  CanDR2 is CanDR -1,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).

% viajan 2 canibales
unPaso([MisIZ, CanIZ, 1, MisIDR, CanDR], [MisIZ2, CanIZ2, 0, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ,
  CanIZ2 is CanIZ +2,
  MisIDR2 is MisIDR,
  CanDR2 is CanDR -2,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).

% viajan 1 de cada
unPaso([MisIZ, CanIZ, 1, MisIDR, CanDR], [MisIZ2, CanIZ2, 0, MisIDR2, CanDR2]):-
  MisIZ2 is MisIZ +1,
  CanIZ2 is CanIZ +1,
  MisIDR2 is MisIDR -1,
  CanDR2 is CanDR -1,
  legal(MisIZ2, CanIZ2, MisIDR2, CanDR2).



camino( E,E, C,C ).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
        unPaso( EstadoActual, EstSiguiente ),
        \+member(EstSiguiente,CaminoHastaAhora),
        camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal ).
solucionOptima:-
    nat(N),
    camino([3,3,0,0,0], [0,0,1,3,3], [[3,3,0,0,0]] , C),
    length(C,N),
    reverse(C,D),
    write(D),!.

% estado -> [3 , 3 , accion , 0, 0]
%             (orilla iz)  ir/volver (orilla der)
%                           0/1
% Buscamos solución de "coste" 0; si no, de 1, etc.
%
% Aqui el coste es la longitud de C (no siempre lo será).
