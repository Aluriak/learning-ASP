%* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Here is implemented a pure sum computation.
There is N sets of atoms value/3, as value(N,X,W) where N is the set unique id,
 X is an element unique id and W a weight defined as an integer.

Goal is to compute sums of weight of elements of each set,
 considering or not repeatitions.
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% score: 8
value(1,a,3).
value(1,b,2).
value(1,c,3).

% score: 7
value(2,d,4).
value(2,e,1).
value(2,e,2). % here is a node repeatition


% weight associated to each set is the sum of its members, independently of its repeations.
weight("all",N,T):- T=#sum{W,N,X,W: value(N,X,W)} ; value(N,_,_).

% weight associated to each set is the sum of its members, without element repeation.
weight("no element rep",N,T):- T=#sum{W,N,X: value(N,X,W)} ; value(N,_,_).

% weight associated to each set is the sum of its members, without weight repeation.
weight("no weight rep",N,T):- T=#sum{W,N,W: value(N,X,W)} ; value(N,_,_).

% weight associated to each set is the sum of its members, without repeation.
weight("no rep",N,T):- T=#sum{W,N: value(N,X,W)} ; value(N,_,_).

% weight associated sum of all values.
weight("set in commons",N,T):- T=#sum{W,X,W: value(_,X,W)} ; value(N,_,_).


#show.
#show weight/3.
