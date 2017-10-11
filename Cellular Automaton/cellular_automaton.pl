% --------------------------------------------------------------
% PROGRAMACION DECLARATIVA
%---------------------------------------------------------------

:- ensure_loaded(automaton).

%----------------------------------------------------------------
% IMPLEMENTACIONES BASICAS PARA LA REALIZACION DE LOS PREDICADOS
%----------------------------------------------------------------

% IMPLEMENTACIONES PARA PARTE 1:
%-------------------------------

% my_append/3
% Concatena 2 listas, dejando el resultado en una lista.
my_append([],X,X).
my_append([X|Y],Z,[X|R]):- my_append(Y,Z,R).

%--------------------------------------------------------------
% PARTE 1: AUTOMATA CELULAR
%--------------------------------------------------------------

% add_zeros/2
% Añade un cero al principio y al final de la lista.
add_zeros(L,Res):- my_append([o],L,L2), my_append(L2,[o],Res).

% iterador/3
% Recorre una lista, sustituyendo cada elemento por su correspondiente segun la regla, 
% y almacenandolo en una nueva lista.  
iterador([_,_],Acc,Acc).
iterador([X,Y,Z|H],Acc,L):- regla(X,Y,Z,Res), my_append(Acc,[Res],NewAcc), iterador([Y,Z|H],NewAcc,L).

% check_head/1 y check_tail/1
% Verifica que los elementos de una lista empiecen por o,x y terminen por x,o.
check_head([o,x|L]):- check_tail(L).
check_tail([x,o|[]]).
check_tail([_|L]):- check_tail(L).

% cells/2
% Dada una lista, se obtiene otra, cuyos elementos son el resultado de aplicar las reglas del automata.
cells(L1,L2):- check_head(L1), add_zeros(L1,Res1),iterador(Res1,[],Res2), add_zeros(Res2,L2).



