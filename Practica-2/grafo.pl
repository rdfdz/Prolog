:-module(_,_).

:-dynamic nodo/2.
:-dynamic arco/2.

% contemplar fallos ?
enumerar(Arco,EnumNodos,EnumArcos):-
	dbNodo(Arco),!,
	findall(elem(K,V),nodo(K,V),EnumNodos),
	findall(elem(K,V),arco(K,V),EnumArcos).
	
dbNodo([]).
dbNodo([X-Y|Z]):-
	hashmap(nodo(X,1)), %% No es aleatorio
	hashmap(nodo(Y,2)), %% fallo inserta repetido
	absoluto(X,Y,K),
	hashmap(arco(X-Y,K)),
	dbNodo(Z).

hashmap(Element):-
	\+(Element),        
	assert(Element).
hashmap(_).

absoluto(X,Y,Z):- nodo(X,V1),nodo(Y,V2), Z is abs(V1-V2).











