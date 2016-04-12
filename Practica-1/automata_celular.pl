:-ensure_loaded(automaton).

% append/2
my_append([],X,X).
my_append([X|Y],Z,[X|R]):- my_append(Y,Z,R).

% add_zeros/2
add_zeros(L,Res):- my_append([o],L,L2), my_append(L2,[o],Res).

% iterador/2
iterador([_,_],Acc,Acc).
iterador([X,Y,Z|H],Acc,L):- regla(X,Y,Z,Res), my_append(Acc,[Res],NewAcc), iterador([Y,Z|H],NewAcc,L). 

%check_head/1
check_head([o,x|L]):- check_tail(L).
check_tail([x,o|[]]).
check_tail([_|L]):- check_tail(L).

% cells/2
cells(L1,L2):- check_head(L1), add_zeros(L1,Res1), iterador(Res1,[],Res2), add_zeros(Res2,L2).

