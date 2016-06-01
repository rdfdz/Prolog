% --------------------------------------------------------------
% PRACTICA 2: PROGRAMACION DECLARATIVA
%
% autores:
% Roberto Daniel Fernandez Castro
% Maria Jose Alobuela Collaguazo
%---------------------------------------------------------------

%--------------------------------------------------------------
% PARTE 2: ACCIDENTE MARITIMO 
%--------------------------------------------------------------

:-module(_,_).

% Equipo = [buzo(gomez,45),buzo(lopez,20),buzo(garcia,40),buzo(perez,15)].
% Tiempo = 80

:-dynamic pareja/3.

% permutation/2 : Permuta los elementos de una lista.
permutation(Bs, [A|As]):-
	append(Xs, [A|Ys], Bs), 
	append(Xs, Ys, Zs),
	permutation(Zs, As). 
permutation([], []).

% sumlist/2 : Suma los elementos de una lista.
sumlist([], 0).
sumlist([X|Xs], S):- sumlist(Xs, S2), S is S2 + X.

% numlist/2 : Crea una lista de numeros, dependiendo de un rango.
numlist(X, X, [X]).
numlist(Von, Bis, [Von | Result]):-
	Von =< Bis, Von1 is Von+1,
	numlist(Von1, Bis, Result).

% timecheck/2 : Comprueba si el tiempo de las parejas es menor o igual al tiempo pasado como argumento. Si falla, realiza el backtraking.
timecheck(Time,Max):- Time =< Max.
timecheck(_,_):- retractall(pareja(_,_,_)), fail.

% insert/6 : Va insertando las parejas de buzos si han trabajado juntos, si han trabajado junto, itera.
insert(B1,B2,T,_,_,_):-
	\+(pareja(B1,B2,_)),
        \+(pareja(B2,B1,_)),
	assert(pareja(B1,B2,T)).
insert(_,_,_,[buzo(B1,T1),buzo(_,_)|R],L,Length):-
	immerse([buzo(B1,T1)|R],L,Length).

% deldiver/3 : Borra un buzo de la lista de buzos
deldiver(buzo(B,_),[buzo(B,_)|Tail],Tail):-!.
deldiver(buzo(B1,_),[buzo(B2,T2)|Tail],[buzo(B2,T2)|Tail1]):-
	deldiver(buzo(B1,_),Tail,Tail1).

% immerse/3 : Va iterando la lista de buzos, insertando si no existen las parejas, y modificando los tiempos de los buzos. Sale cuando se han completado todas las parejas posibles.
immerse([buzo(B1,T1),buzo(B2,T2)|R],L,Length) :- 
	T1=T2,
	insert(B1,B2,T1,[buzo(B1,T1),buzo(B2,T2)|R],L,Length),
	immerse(R,L,Length),!.
immerse([buzo(B1,T1),buzo(B2,T2)|R],L,Length) :- 
	(T1 < T2 -> T = T1, B = B2 ; T = T2, B = B1),
	insert(B1,B2,T,[buzo(B1,T1),buzo(B2,T2)|R],L,Length),
	TR is abs(T1 -T2),
	immerse([buzo(B,TR)|R],L,Length),!.
immerse(_,_,Length):- 
	findall(pareja(X,Y,Z),pareja(X,Y,Z),L),
	length(L,R),
	R =:= Length,!.
immerse([buzo(B1,T1)],List,Length):-
	deldiver(buzo(B1,_),List,Del),
	append([buzo(B1,T1)],Del,NewList),
	immerse(NewList,Del,Length),!.
immerse([],List,Length):-
	immerse(List,List,Length),!.

% reparacion/3 : Realiza un algoritmo de Backtracking donde va insertando parejas y comprobando si no superan el tiempo. Si lo consigue devuelve una lista de parejas con la posible solucion, si no va realizando Backtracking hasta que no queden mas posibilidades. Da varias soluciones posibles.
reparacion(Equipo,Tiempo,OrdenParejas):-
	permutation(Equipo,Backtraking),
	length(Equipo,Len),
	Leng is Len - 1,
	numlist(0,Leng,NumPareja),
	sumlist(NumPareja,LenPareja),
	immerse(Backtraking,Backtraking,LenPareja),
	findall(T,pareja(_,_,T), LT),
	sumlist(LT,Total),
	timecheck(Total,Tiempo),
	findall(pareja(X,Y,Z),pareja(X,Y,Z),OrdenParejas),
	retractall(pareja(_,_,_)).


