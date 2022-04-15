

use_module(library(clpfd)).

nat(0).
nat(N) :- nat(N1), N is N1 + 1.

unPaso([[15,T,M,E],left], [[0,T,M,E],rigth],15).
unPaso([[P,16,M,E],left], [[P,0,M,E],rigth],16).
unPaso([[P,T,70,E],left], [[P,T,0,E],rigth],70).
unPaso([[P,T,M,65],left], [[P,T,M,0],rigth],65).


unPaso([[15,16,M,E],left],[[0,0,M,E],rigth],16).
unPaso([[15,T,70,E],left],[[0,T,0,E],rigth],70).
unPaso([[15,T,M,65],left],[[0,T,M,0],rigth],65).
unPaso([[P,16,70,E],left],[[P,0,0,E],rigth],70).
unPaso([[P,16,M,65],left],[[P,0,M,0],rigth],65).
unPaso([[P,T,70,65],left],[[P,T,0,0],rigth],70).


unPaso([[0,T,M,E],rigth], [[15,T,M,E],left],15).
unPaso([[P,0,M,E],rigth], [[P,16,M,E],left],16).
unPaso([[P,T,0,E],rigth], [[P,T,70,E],left],70).
unPaso([[P,T,M,0],rigth], [[P,T,M,65],left],65).


unPaso([[0,0,M,E],rigth],[[15,16,M,E],left],16).
unPaso([[0,T,0,E],rigth],[[15,T,70,E],left],70).
unPaso([[0,T,M,0],rigth],[[15,T,M,65],left],65).
unPaso([[P,0,0,E],rigth],[[P,16,70,E],left],70).
unPaso([[P,0,M,0],rigth],[[P,16,M,65],left],65).
unPaso([[P,T,0,0],rigth],[[P,T,70,65],left],70).


camino( E,E, C,C ,_).
camino( EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ,T):-
        % write("Executam un pas"),
        unPaso( EstadoActual, EstSiguiente,TempsGastat ),
        \+member(EstSiguiente,CaminoHastaAhora),
        T1 is T - TempsGastat,
        T1>= 0,
        camino( EstSiguiente, EstadoFinal, [EstSiguiente|CaminoHastaAhora], CaminoTotal,T1 ).
solucionOptima:-
    nat(N),
    camino([[15,16,70,65],left],[[0,0,0,0],rigth] ,[[[15,16,70,65],left]], C,N),
    reverse(C,R),
    write(R),nl,
    write("Temps usat="),write(N),!.
