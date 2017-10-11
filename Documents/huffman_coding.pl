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
% PARTE 2: CODIFICACION HUFFMAN PLOG 
%-------------------------------------------------------------

% arbolBalanceadoPar/1 
% Dado un arbol, se comprueba que la suma de los pesos pares de su arbol izquierdo es igual a la suma 
% de los pesos pares de su arbol derecho.
arbolBalanceadoPar(void).
arbolBalanceadoPar(tree(par(_,_),Left,Right)):-
	rama(Left,0,0,Res),
	rama(Right,0,0,Res).

% rama/4
% Realiza la suma de los pesos pares del arbol.
rama(void,_,_,_).
rama(tree(par(_,N),Left,Right),Acc1,Acc2,Res):-
	mod(N,s(s(0)),0),
	rama(Left,Acc1,Acc2,Acc1),
	rama(Right,Acc1,Acc2,Acc2),
	plus(Acc1,Acc2,N1),
	plus(N1,N,Res).

% Realiza la suma de los pesos impares del arbol.
rama(tree(par(_,N),Left,Right),Acc1,Acc2,Res):-
	mod(N,s(s(0)),s(0)),
	rama(Left,Acc1,Acc2,Acc1),
	rama(Right,Acc1,Acc2,Acc2),
	plus(Acc1,Acc2,Res).
	

% arbolAmplificado/2
% Dado un arbol, se incrementa el peso de los nodos en el numero de veces que indica la raiz del arbol origen.
arbolAmplificado(void,_).
arbolAmplificado(tree(par(S,N),L,R),AAmp):-
	subtree(L,N,LAmp),
	subtree(R,N,RAmp),
	AAmp = tree(par(S,N),LAmp,RAmp).


% subtree/3
% Recorre el hijo izquierdo y el hijo derecho del arbol origen, devolviendolos con el peso de los nodos amplificados.
subtree(void,_,void).
subtree(tree(par(S,N),L,R),Root,STree):-
	subtree(L,Root,L1),
	subtree(R,Root,R1),
	times(N,Root,Res),
	STree = tree(par(S,Res),L1,R1).
