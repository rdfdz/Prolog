:-module(_,_).

:-dynamic nodo/2.
:-dynamic arco/2.

% contemplar fallos ?
enumerar(Arco,EnumNodos,EnumArcos):-
	length(Arco,Z),
	X is Z+1,
	findall(Y,between(1,X,Y),Xs),
	fun(Xs,[],L),
	dbNodo(Arco,L),!,
	findall(elem(K,V),nodo(K,V),EnumNodos),
	findall(elem(K,V),arco(K,V),EnumArcos),
	retractall(nodo(_,_)),
	retractall(arco(_,_)).
	
dbNodo([],_).
dbNodo([X-Y|Z],L):-
	hashmap(X,L,L1), %% No es aleatorio
	hashmap(Y,L1,L2), %% fallo inserta repetido
	absoluto(X,Y,K),
	hashmap1(arco(X-Y,K)),
	dbNodo(Z,L2).

hashmap(K,[V|T],L):-
	\+(nodo(K,_)),        
	assert(nodo(K,V)),
	L = T.
hashmap(_,L,L).

hashmap1(Element):-
        assert(Element).

absoluto(X,Y,Z):- nodo(X,V1),nodo(Y,V2), Z is abs(V1-V2).

fun([],Acc,Acc).
fun([First|Y],Acc,L):-
	last1([First|Y],Last),
	First \=Last,
	append(Acc,[Last,First],Acc2),
	delete([First|Y],First,L1),
	delete(L1,Last,L2),
	fun(L2,Acc2,L).
fun([First|Y],Acc,L):-
	append(Acc,[First],L),
	fun(Y,L,L).
	

	

last1([_|Rest],Last):-last1(Rest,Last).
last1([Last],Last).
  










