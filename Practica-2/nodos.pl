% --------------------------------------------------------------
% PRACTICA 2: PROGRAMACION DECLARATIVA
%
% autores:
% Roberto Daniel Fernandez Castro
% Maria Jose Alobuela Collaguazo
%---------------------------------------------------------------

%--------------------------------------------------------------
% PARTE 1: PROBLEMA DE ENUMERACION
%--------------------------------------------------------------

:-module(_,_).

% Modificaciones dinamicas para añadir clausulas a la base de conocimientos
:-dynamic nodo/2.
:-dynamic arco/2.

% database/2
% Recorre la lista de las aristas del grafo y la lista de la secuencia de numeros para unir cada nodo o arco con su respectivo numero.
database([],_).
database([X-Y|Z],L):-
	hashmap(X,L,L1), 
	hashmap(Y,L1,L2), 
	absolute(X,Y,V),
	assert(arco(X-Y,V)),
	database(Z,L2).

% hashmap/3
% inserta en la base de hechos cada uno de los nodos del grafo.
hashmap(K,[V|T],L):-
	\+(nodo(K,_)),        
	assert(nodo(K,V)),
	L = T.
hashmap(_,L,L).

% absolute/3
% calcula la diferencia en valor absoluto de V1-V2 para asignar dicho numero a la arista.
absolute(X,Y,Z):- nodo(X,V1),nodo(Y,V2), Z is abs(V1-V2).

% position_node/3
% Devuelve una lista con la secuencia adecuada para enumerar a los nodos del grafo
position_node([],Acc,Acc).
position_node([First|Y],Acc,L):-
	last([First|Y],Last),
	First \= Last,
	append(Acc,[Last,First],Acc2),
	delete(Y,Last,L1),
	position_node(L1,Acc2,L).
position_node([First|Y],Acc,L):-
	append(Acc,[First],L),
	position_node(Y,L,L).
	
% enumerar/3
% Dada una lista con las aristas de un grafo conexo, se enumeran sus nodos y arcos con sus correspondientes numeros. 
enumerar(Arco,EnumNodos,EnumArcos):-
	length(Arco,Long),
	findall(X,between(1,Long+1,X),Xs),
	position_node(Xs,[],L),
	database(Arco,L),!,
	findall(enum(V,K),nodo(K,V),EnumNodos),
	findall(enum(V,K),arco(K,V),EnumArcos),
	retractall(nodo(_,_)),
	retractall(arco(_,_)).
