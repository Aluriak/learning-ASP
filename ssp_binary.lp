% SSP problem encoding.
% Here in a binary implementation : an object is taken, or not.

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

% Choose a subset of objects (binary).
{choose(X,V): obj(X,V)}.

% Avoid model that doesn't reach exactly the capacity.
:- capacity!=#sum{Val,X: choose(X,Val)}.

#show.
#show choose/2.
