% SSP problem encoding.
% Here allowing an object to be used multiple times.

#const capacity=50.

% Instance encoding: obj(X,Y) describe an object of type X and value Y.
obj(1,41).
obj(2,34).
obj(3,21).
obj(4,20).
obj(5,8).
obj(6,7).
obj(7,7).
obj(8,4).
obj(9,3).
obj(10,3).

% We have at most capacity/value objects of one type.
maxobj(O,N):- obj(O,V) ; N=capacity/V.
obj(O,V,1..N):- obj(O,V) ; maxobj(O,N).

% Choose a subset of objects (an object can be taken multiple times)
0{choose(O,V,1)}1:- obj(O,V,1).
0{choose(O,V,N)}1:- choose(O,V,N-1) ; N<=M ; maxobj(O,M).  % we can get N if already have N-1

% Avoid model that doesn't reach exactly the capacity.
:- capacity!=#sum{Val,O,N: choose(O,Val,N)}.

#show.
#show choose/3.  % object id, object value, object number
