:-module(_,_).

% Funciones Adicionales
nat(0).
nat(s(X)):-nat(X).

plus(0,X,X):-nat(X).
plus(s(X),Y,s(Z)):- plus(X,Y,Z).

less(0,s(X)):- nat(X).
less(s(X),s(Y)) :- less(X,Y).

mod(X,Y,X) :- less(X,Y).
mod(X,Y,Z) :- plus(X1,Y,X), mod(X1,Y,Z).
 
times(X,0,0):-nat(X).
times(X,s(Y),Z):- times(X,Y,Acc), plus(Acc,X,Z).

numpar(N,Acc,R):- mod(N,s(s(0)),0), plus(Acc,N,R).
numpar(N,Acc,R):- mod(N,s(s(0)),s(0)),plus(0,Acc,R). 

% arbolBalanceadoPar/1 
arbolBalanceadoPar(void).
arbolBalanceadoPar(tree(par(_,_),Left,Right)):-
	rama(Left,Res1),
	rama(Right,Res2),
	!,
	Res1 = Res2.

rama(void,_).
rama(tree(par(_,N),Left,Right),Res):-
	rama(Left,Acc),
	rama(Right,Acc),
	numpar(N,Acc,Res).

% arbolAmplificado/2
arbolAmplificado(void,_).
arbolAmplificado(tree(par(S,N),L,R),AAmp):-
	subtree(L,N,LAmp),
	subtree(R,N,RAmp),
	AAmp = tree(par(S,N),LAmp,RAmp).

subtree(void,_,void).
subtree(tree(par(S,N),L,R),Root,STree):-
	subtree(L,Root,L1),
	subtree(R,Root,R1),
	times(N,Root,Res),
	STree = tree(par(S,Res),L1,R1).

