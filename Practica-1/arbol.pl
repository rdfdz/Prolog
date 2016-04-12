:-module(_,_).

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



% arbolBalanceadoPar/1 
arbolBalanceadoPar(void).
arbolBalanceadoPar(tree(par(_,_),Left,Right)):-
	leaf(Left,Res1),
	leaf(Right,Res2),
	cmp(Res1,Res2).

leaf(void,_).
leaf(tree(par(_,N1),Left,Right),RES):-
	leaf(Left,Acc),
	leaf(Right,Acc),
	plus(Acc,N1,RES).

cmp(X,Y):- X\=Y.

% arbolAmplifcado/2
arbolAmplificado(void,_).
arbolAmplificado(tree(par(S,N),L,R),AAmp):-
	subtree(L,N,LL),
	subtree(R,N,LR),
	AAmp = tree(par(S,N),LL,LR).

subtree(void,_,void).
subtree(tree(par(S,N),L,R),Root,STree):-
	subtree(L,Root,L1),
	subtree(R,Root,R1),
	times(N,Root,Res),
	STree = tree(par(S,Res),L1,R1).
	
