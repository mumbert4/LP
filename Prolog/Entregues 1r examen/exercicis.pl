%EXERCICIS PROLOG
%FUNCIONS DEFINIDES : permutation(L1,L), append(L1,L2,L), member(X,L)




%1. Escribe un predicado prod(L,P) que signifique: “P es el producto de los elementos de la lista
% de enteros dada L”. Debe poder generar la P y también comprobar una P dada.

prod([],1).
prod([X|L],P):- prod(L,P1), P is P1 * X.


% 2. Escribe un predicado pescalar(L1,L2,P) que signifique: “P es el producto escalar de los
% vectores L1 y L2”, donde los vectores se representan como listas de enteros. El predicado debe
% fallar si los dos vectores tienen longitudes distintas.
pescalar([],[],0):-!.
pescalar([], _, _):- fail.
pescalar(_, [], _):- fail.
pescalar([X1|L1],[X2|L2],P):- X is X1 * X2, pescalar(L1,L2,P1), P is X + P1.


% 3. Representando conjuntos con listas sin repeticiones, escribe predicados para las operaciones de
% intersección y unión de conjuntos dados.

%INTERSECCIO v1-> no eliminam el parametre de les dues llistes quan coincideix, nomes el llevam de una

inter([],_,[]).
inter([X1|L1],L2,[X1|L]):- member(X1,L2),!, inter(L1,L2,L).
inter([_|L1],L2,L):-inter(L1,L2,L).


% INTERSECCIO v2-> si coincideixen, els llevam als 2 de les llistes

interV2([],_,[]).
interV2([X1|L1], L2, [X1|L]):- member(X1,L2),!, pop(X1,L2,NewL2), interV2(L1, NewL2, L).
interV2([_|L1],L2,L):- interV2(L1,L2,L).

% pop(_,[],[]).
% pop(X,[X],[]).
pop(X,[Y|L],[Y|L2]):- pop(X,L,L2).
pop(X,[X|L],L):-!.


%UNIO
union([],L,L).
union([X1|L1],L2,L):-member(X1,L2),!,union(L1,L2,L).
union([X1|L1],L2,[X1|L]):-union(L1,L2,L).




% 4. Usando concat(append), escribe un predicado para calcular el último elemento de una lista dada, y otro
% para calcular la lista inversa de una lista dada.

last_elem(L1,X):- append(_,[X],L1).

inversa([],[]).
% inversa(L1,[X|L2]):- last_elem(L1,X), append(NewL1,[X],L1), inversa(NewL1,L2).
inversa(L1,[X|L2]):-append(NewL1,[X],L1), inversa(NewL1,L2).






% 5. Escribe un predicado fib(N,F) que signifique: “F es el N-ésimo número de Fibonacci para la
% N dada”. Estos números se definen ası́: fib(1) = 1, fib(2) = 1, y si N > 2 entonces fib(N ) =
% fib(N − 1) + fib(N − 2).

fib(1,1):-!.
fib(2,1):-!.
fib(N,F):-N1 is N -1, N2 is N - 2, fib(N1,F1), fib(N2,F2), F is F1 + F2.




% 6. Escribe un predicado dados(P,N,L) que signifique: “la lista L expresa una manera de sumar
% P puntos lanzando N dados”. Por ejemplo: si P es 5 y N es 2, una solución serı́a [1,4] (nótese
% que la longitud de L es N). Tanto P como N vienen instanciados. El predicado debe ser capaz de
% generar todas las soluciones posibles.




% 7. Escribe un predicado suma demas(L) que, dada una lista de enteros L, se satisface si existe algún
% elemento en L que es igual a la suma de los demás elementos de L, y falla en caso contrario.

suma([],0).
suma([X1|L], X):- suma(L,X2), X is X1 + X2.

suma_demas(L) :- select(X,L,R), suma(R,X), !.

% 8. Escribe un predicado suma ants(L) que, dada una lista de enteros L, se satisface si existe algún
% elemento en L que es igual a la suma de los elementos anteriores a él en L, y falla en caso
% contrario.

suma_ants(L):- append(L1, [X|_],L), suma(L1,X),!.



% 10. Escribe un predicado esta ordenada(L) que signifique: “la lista L de números enteros está
% ordenada de menor a mayor”


esta_ordenada([]):-!.
esta_ordenada([_]):-!.
% esta_ordenada([X,Y|L]):- not(X < Y), write("No"),fail,!.
esta_ordenada([X,Y|L]):- X =< Y,esta_ordenada([Y|L]),!.




% 11. Escribe un predicado ord(L1,L2) que signifique: “L2 es la lista de enteros L1 ordenada de
% menor a mayor”. Por ejemplo: si L1 es [4,5,3,3,2] entonces L2 será [2,3,3,4,5]. Hazlo en
% una lı́nea, usando sólo los predicados permutacion y esta ordenada.


ord(L1,L2):- permutation(L1,L2), esta_ordenada(L2).



% 12. Escribe un predicado diccionario(A,N) que, dado un alfabeto A de sı́mbolos y un natural N,
% escriba todas las palabras de N sı́mbolos, por orden alfabético (el orden alfabético es según el
% alfabeto A dado).

% diccionario(A,N)





% 20. Write in Prolog a predicate flatten(L,F) that “flattens” (cast.: “aplana”) the list F


flatten([],[]).
flatten([X|L],[X|F]):-flatten(L,F).
flatten([X|L],F):-flatten(X,F1), flatten(L,F2),write(F1), write(F2).
