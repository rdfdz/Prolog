:-module(_,_).

:-dynamic nodo/2.

enumerar(Arco,EnumNodos,_):-
	dbNodo(Arco),!,
	findall(elem(X,Y),nodo(X,Y),EnumNodos).
	
dbNodo([]).
dbNodo([X-Y|Z]):-
	hashmap(nodo(X,1)),
	hashmap(nodo(Y,1)),
	dbNodo(Z).

hashmap(Element):-
	\+(Element),        
	assert(Element).
hashmap(_).




delete(V):-retract(nodo(V,_)).
limpiar(X,Y):-retractall(nodo(X,Y)).


nodos([],[]).
nodos([X-Y|Z],L):-
	append([X,Y],Acc,L),
	nodos(Z,Acc).

asignacion(L,_):-
	nodos(L,N),
	sort(N,X),
	write(X).









