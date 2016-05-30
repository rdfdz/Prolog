:-module(_,_).

% Equipo = [buzo(gomez,45),buzo(lopez,20),buzo(garcia,40),buzo(perez,15)].
% Tiempo = 80

:-dynamic pareja/3.


immerse([buzo(B1,T1),buzo(B2,T2)|R],L) :- 
	T1>T2,
	assert(pareja(B1,B2,T2)),
	TR is abs(T1 -T2),
	immerse([buzo(B1,TR)|R],L),!.
immerse([buzo(B1,T1),buzo(B2,T2)|R],L) :- 
	T1<T2,
	assert(pareja(B1,B2,T1)),
	TR is abs(T1 -T2),
	immerse([buzo(B2,TR)|R],L),!.
immerse([buzo(B1,T1),buzo(B2,T2)|R],L) :- 
	T1=T2,
	assert(pareja(B1,B2,T1)),
	immerse(R,L),!.
immerse(L,List):-  
%	findall(X,pareja(X,garcia,Z),L1),
%	findall(Y,pareja(garcia,Y,Z),L2),
	write(L),nl,write(List),!.

prueba([buzo(B,T)],List,FIN):-
	findall(X,pareja(X,garcia,Z),L1),
	findall(Y,pareja(garcia,Y,Z),L2),
	append([L1],L2,FIN).

exist(Element,[buzo(B,_)|R],R):- Element = B.
exist(Element,[buzo(B,_)|R],[buzo(B,_)|R1]):-
	exist(Element,R,R1).















permutation(Bs, [A|As]):-
	append(Xs, [A|Ys], Bs), 
	append(Xs, Ys, Zs),
	permutation(Zs, As). 
permutation([], []).

timecheck(Time,Max):- Time =< Max.
timecheck(_,_):- retractall(pareja(_,_,_)), fail.

sumlist([], 0).
sumlist([X|Xs], S):- sumlist(Xs, S2), S is S2 + X.

reparacion(Equipo,Tiempo,OrdenParejas):-
	permutation(Equipo,Backtraking),
	immerse(Backtraking,Backtraking),
	findall(T,pareja(_,_,T), LT),
	sumlist(LT,Total), %write(LT),write(Sum),nl,
	timecheck(Total,Tiempo),
	findall(pareja(X,Y,Z),pareja(X,Y,Z),OrdenParejas).
	%retractall(pareja(_,_,_)).

