:-module(_,_).


arbolBalanceadoPar(void).
arbolBalanceadoPar(tree(par(_,N),Left,Right)):-
	leaf(Left,N,_),
	leaf(Right,N,_).

leaf(void,_,_).
leaf(tree(par(_,N),Left,Right),_,_):-
	write(N),
	leaf(Left,_,_),
	leaf(Right,_,_).







nat(0).
nat(s(X)):-nat(X).

plus(0,X,X):-nat(X).
plus(s(X),Y,s(Z)):- plus(X,Y,Z).

less(0,s(X)):- nat(X).
less(s(X),s(Y)) :- less(X,Y).

mod(X,Y,X) :- less(X,Y).
mod(X,Y,Z) :- plus(X1,Y,X), mod(X1,Y,Z).

numpar(N):- mod(N,s(s(0)),0).  