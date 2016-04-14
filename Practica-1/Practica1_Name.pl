:-module(_,_).

%---------------------------------------------------------------
% Implementaciones basicas para la realizacion de los predicados
%---------------------------------------------------------------

% IMPLEMENTACIONES PARA PARTE 1:
%-------------------------------

% my_append/2
% Concatena 2 listas, dejando el resultado en una lista.
my_append([],X,X).
my_append([X|Y],Z,[X|R]):- my_append(Y,Z,R).



% IMPLEMENTACIONES PARA PARTE 2:
%-------------------------------
% nat/1
% Verifica que los numeros son naturales.
nat(0).
nat(s(X)):-nat(X).

% plus/3
% Suma los elementos X e Y, dejando el resultado en Z.
plus(0,X,X):-nat(X).
plus(s(X),Y,s(Z)):- plus(X,Y,Z).

% less/2
% Comprueba que X es menor que Y
less(0,s(X)):- nat(X).
less(s(X),s(Y)) :- less(X,Y).

% mod/3
% Realiza el modulo de X e Y, dejando el resultado en Z.
mod(X,Y,X) :- less(X,Y).
mod(X,Y,Z) :- plus(X1,Y,X), mod(X1,Y,Z).
 
% times/3
% Multiplica los elementos X e Y, dejando el resultado en Z.
times(X,0,0):-nat(X).
times(X,s(Y),Z):- times(X,Y,Acc), plus(Acc,X,Z).


%--------------------------------------------------------------
% Parte 2: arbolBalanceadoPar y arbolAmplificado
%-------------------------------------------------------------

% arbolBalanceadoPar/1 
arbolBalanceadoPar(void).
arbolBalanceadoPar(tree(par(_,_),Left,Right)):-
	rama(Left,0,0,Res),
	rama(Right,0,0,Res).

rama(void,_,_,_).
rama(tree(par(_,N),Left,Right),Acc1,Acc2,Res):-
	mod(N,s(s(0)),0),
	rama(Left,Acc1,Acc2,Acc1),
	rama(Right,Acc1,Acc2,Acc2),
	plus(Acc1,Acc2,N1),
	plus(N1,N,Res).

rama(tree(par(_,N),Left,Right),Acc1,Acc2,Res):-
	mod(N,s(s(0)),s(0)),
	rama(Left,Acc1,Acc2,Acc1),
	rama(Right,Acc1,Acc2,Acc2),
	plus(Acc1,Acc2,Res).
	

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
