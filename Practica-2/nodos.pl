:-module(_,_).

:-dynamic nodo/2.
:-dynamic arco/2.

enumerar(Arco,EnumNodos,EnumArcos):-
	length(Arco,Long),
	findall(X,between(1,Long+1,X),Xs),
	position_node(Xs,[],L),
	database(Arco,L),!,
	findall(elem(K,V),nodo(K,V),EnumNodos),
	findall(elem(K,V),arco(K,V),EnumArcos),
	retractall(nodo(_,_)),
	retractall(arco(_,_)).
	
database([],_).
database([X-Y|Z],L):-
	hashmap(X,L,L1), 
	hashmap(Y,L1,L2), 
	absolute(X,Y,V),
	assert(arco(X-Y,V)),
	database(Z,L2).

hashmap(K,[V|T],L):-
	\+(nodo(K,_)),        
	assert(nodo(K,V)),
	L = T.
hashmap(_,L,L).

absolute(X,Y,Z):- nodo(X,V1),nodo(Y,V2), Z is abs(V1-V2).

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
	
