:-module(_,_).

% Equipo = [buzo(gomez,45),buzo(lopez,20),buzo(garcia,40),buzo(perez,15)].
% Tiempo = 80

:-dynamic pareja/3.

permutation(Bs, [A|As]):-
	append(Xs, [A|Ys], Bs), 
	append(Xs, Ys, Zs),
	permutation(Zs, As). 
permutation([], []).

immerse([]).
immerse([buzo(B1,T1),buzo(B2,T2)|R]) :- 
	T1>T2,
	assert(pareja(B1,B2,T2)),
	R \= [],
	TR is abs(T1 -T2),
	immerse([buzo(B1,TR)|R]),!.
immerse([buzo(B1,T1),buzo(B2,T2)|R]) :- 
	T1<T2,
	assert(pareja(B1,B2,T1)),
	R \= [],
	TR is abs(T1 -T2),
	immerse([buzo(B2,TR)|R]),!.
immerse([buzo(B1,T1),buzo(B2,T2)|R]) :- 
	T1=T2,
	assert(pareja(B1,B2,T1)),
	immerse(R),!.
immerse(_):-!.


timecheck(Time,Max):- Time =< Max.
timecheck(_,_):- retractall(pareja(_,_,_)), fail.

sumlist([], 0).
sumlist([X|Xs], S):-
          sumlist(Xs, S2),
          S is S2 + X.

reparacion(Equipo,Tiempo,OrdenParejas):-
	permutation(Equipo,Backtraking),
	immerse(Backtraking),
	findall(T,pareja(_,_,T), LT),
	sumlist(LT,Total), %write(LT),write(Sum),nl,
	timecheck(Total,Tiempo),
	findall(pareja(X,Y,Z),pareja(X,Y,Z),OrdenParejas),
	retractall(pareja(_,_,_)).

