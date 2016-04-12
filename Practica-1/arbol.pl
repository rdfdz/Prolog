:-module(_,_).


arbolBalanceadoPar(void).
arbolBalanceadoPar(tree(par(_,_),Left,Right)):-
	leaf(Left,Res1),
	leaf(Right,Res2),
	write(Res1),
	write(Res2).

leaf(void,_).
leaf(tree(par(_,N1),Left,Right),RES):-
	leaf(Left,Acc),
	leaf(Right,Acc),
	plus(Acc,N1,RES).



nat(0).
nat(s(X)):-nat(X).

plus(0,X,X):-nat(X).
plus(s(X),Y,s(Z)):- plus(X,Y,Z).

less(0,s(X)):- nat(X).
less(s(X),s(Y)) :- less(X,Y).

mod(X,Y,X) :- less(X,Y).
mod(X,Y,Z) :- plus(X1,Y,X), mod(X1,Y,Z).

numpar(N):- mod(N,s(s(0)),0).  