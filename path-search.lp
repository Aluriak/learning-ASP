% Path search in a (directed) graph, from one point to another, while passing through milestones.
% Possible improvements:
%  - make the milestones optional, by removing the constraint on path, and maximizing the number
%    of different milestones that are encountered. Different priorities can then be assigned
%    to path length and covered milestones.



% INSTANCE EXAMPLE
% missing positions are simply those that are not practicables.
position(1,1).                position(3,1). position(4,1). position(5,1).
position(1,2). position(2,2). position(3,2). position(4,2).
position(1,3). position(2,3).                position(4,3). position(5,3).
position(1,4). position(2,4). position(3,4).                position(5,4).
position(1,5). position(2,5). position(3,5). position(4,5). position(5,5).

milestone(1,5).  % the two corners
milestone(5,1).  % will pass by all of them.

start(1,1).
goals((1,1);(5,5)).  % will stop at one of them.

% There is a slide that allow to go from 1,5 to 1,4, so the reverse move is not possible:
blocked((1,4),(1,5)).

% Best answer: 11 -> 12 -> 13 -> 24 -> 15 -> 25 -> 34 -> 43 -> 42 -> 51 -> 41 -> 31 -> 22 -> 11



% PROGRAM
#const path_maxlen=100.

% Define the graph links based on available positions.
edge((X,Y),(I,J)):- position(X,Y) ; position(I,J) ; |X-I|=0..1 ; |Y-J|=0..1 ; |X-I|+|Y-J|=1..2 ; not blocked((X,Y),(I,J)).
% allow diagonal moves. To disable it, make |X+Y-I-J| equals to 1 instead of 1..2.

% All user-defined goals are linked to the endgoal, a virtual node that is the real end.
edge(G,endgoal):- goals(G).

% Path from start pos to the goal.
path(1,(X,Y)):- start(X,Y).
0{path(N+1,E): path(N,S), edge(S,E), S!=endgoal}1:- path(N,_) ; N<path_maxlen.

% Shortcut to last move step.
pathlen(N):- path(N,_) ; not path(N+1,_).

% A path that do not join the end is illegal.
:- path(N,E) ; pathlen(N) ; not E=endgoal.
% A path must go by all milestone.
:- not path(_,(X,Y)) ; milestone(X,Y).


% Minimize the number of steps.
#minimize{N: pathlen(N)}.


% Outputs.
#show.
#show path/2.
#show milestone(N,(X,Y)): milestone(X,Y), path(N,(X,Y)), path(M,_), not path(M,(X,Y)), M<N.
