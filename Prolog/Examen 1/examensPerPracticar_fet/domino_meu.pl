% chain(L,R)

chain2([],[]).
chain2([[X,Y]], [[X,Y]]).
chain2([[X,Y]], [[Y,X]]).
chain2([[X,Y]|L], [[X,Y]|R]) :- chain2(L,R), R = [ [Y,_] | _ ].
chain2([[X,Y]|L], [[Y,X]|R]) :- chain2(L,R), R = [ [X,_] | _ ].


reverse([X,Y], [Y,X]).

% all_chains([]):- write("[]"),nl.
all_chains([X]):-write(X), reverse(X,Y), nl ,write(Y),nl.
all_chains([X|L]):-all_chains(L), aux(X) ,chain2([X|L], R), nl ,write(R).


aux(X):- write(X), reverse(X,Y), nl ,write(Y),nl.
