:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

%Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
    length(D1,6),
    length(D2,6),
    length(D3,6),
    length(D4,6),


    D1 ins 1..24,
    D2 ins 1..24,
    D3 ins 1..24,
    D4 ins 1..24,

    append(D1,D2,Aux),
    append(D3,Aux,Aux2),
    append(D4,Aux2,Todos),

    all_different(Todos), % comprobamos que los dados tienen caras diferentes
    write("Todos diferentes"),
    findall(T, word(T), Lits),

    constraints(Lits,D1,D2,D3,D4),

    label(Todos),
    writeN(D1),
    writeN(D2),
    writeN(D3),
    writeN(D4), halt.

writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.



constraints([],_,_,_,_).
constraints([Word|Resta],D1,D2,D4,D4):-
  noRepeated(Word,D1),
  noRepeated(Word,D2),
  noRepeated(Word,D3),
  noRepeated(Word,D4),
  constraints(Resta,D1,D2,D3,D4).

noRepeated([L1,L2,L3,L4],[C1,C2,C3,C4,C5,C6]):-
  num(L1,X1),
  num(L2,X2),
  num(L3,X3),
  num(L4,X4),
  comparaciones(C1,C2,X1,X2,X3,X4),
  comparaciones(C1,C3,X1,X2,X3,X4),
  comparaciones(C1,C4,X1,X2,X3,X4),
  comparaciones(C1,C5,X1,X2,X3,X4),
  comparaciones(C1,C6,X1,X2,X3,X4),
  comparaciones(C2,C3,X1,X2,X3,X4),
  comparaciones(C2,C4,X1,X2,X3,X4),
  comparaciones(C2,C5,X1,X2,X3,X4),
  comparaciones(C2,C6,X1,X2,X3,X4),
  comparaciones(C3,C4,X1,X2,X3,X4),
  comparaciones(C3,C5,X1,X2,X3,X4),
  comparaciones(C3,C6,X1,X2,X3,X4),
  comparaciones(C4,C5,X1,X2,X3,X4),
  comparaciones(C4,C6,X1,X2,X3,X4),
  comparaciones(C5,C6,X1,X2,X3,X4).




comparaciones(X1,X2,L1,L2,L3,L4):-
    X1 #\= L1 #\/ X2 #\= L2,
    X1 #\= L1 #\/ X2 #\= L3,
    X1 #\= L1 #\/ X2 #\= L4,
    X1 #\= L2 #\/ X2 #\= L1,
    X1 #\= L2 #\/ X2 #\= L3,
    X1 #\= L2 #\/ X2 #\= L4,
    X1 #\= L3 #\/ X2 #\= L1,
    X1 #\= L3 #\/ X2 #\= L2,
    X1 #\= L3 #\/ X2 #\= L4,
    X1 #\= L4 #\/ X2 #\= L1,
    X1 #\= L4 #\/ X2 #\= L2,
    X1 #\= L4 #\/ X2 #\= L3.
