:-module(_,_).

arbolBalanceadoPar(void).
arbolBalanceadoPar(tree(par(_,_),Left,Right)):-
	leaf(Left,Res1),
	leaf(Right,Res2),
	cmp(Res1,Res2).

cmp(X,Y):- X\=Y.

leaf(void,_).
leaf(tree(par(_,N1),Left,Right),RES):-
	leaf(Left,Acc),
	leaf(Right,Acc),
	plus(Acc,N1,RES).


equals(A,B):-A=B.
nat(0).
nat(s(X)):-nat(X).

plus(0,X,X):-nat(X).
plus(s(X),Y,s(Z)):- plus(X,Y,Z).

less(0,s(X)):- nat(X).
less(s(X),s(Y)) :- less(X,Y).

mod(X,Y,X) :- less(X,Y).
mod(X,Y,Z) :- plus(X1,Y,X), mod(X1,Y,Z).

numpar(N):- mod(N,s(s(0)),0).  

times(X,0,0):-nat(X).
times(X,s(Y),Z):- times(X,Y,Acc), plus(Acc,X,Z).


arbolAmplificado(tree(par(S,N),Left,Right),AAmp):-
	tree(Left,N,L1),
	tree(Right,N,L2),
	AAmp = tree(par(S,N),L1,L2).

tree(void,_,void).
tree(tree(par(X,N),L,R),Root,AAmp):-
	tree(L,Root,L1),
	tree(R,Root,L2),
	times(N,Root,Res),
	AAmp = tree(par(X,Res),L1,L2).
	
