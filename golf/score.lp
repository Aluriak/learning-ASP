
% input : board(X,Y,V) with X,Y the coordinates of the V value

domain(X,Y):- board(X,Y,_).
player("1";"2";"3";"4").

% neighbors of X,Y
neighbors(X,Y,((X-2,Y);(X+2,Y);((X-1;X+1),(Y-1;Y+1)))) :- domain(X,Y).
neighbors(X,Y,I,J):- neighbors(X,Y,(I,J)) ; domain(I,J).

% Player is next to X,Y iff has a settlement next to.
next(X,Y,P):- neighbors(X,Y,I,J) ; board(I,J,P).


% SCORES
% Core score : 3 point for each Castle "C" with at least one settlement next to.
score(core,P,S*3):- S={next(X,Y,P): board(X,Y,"C")} ; player(P).

% opt1: 1 point per settled row
score(opt1,P,S*1):- S=#count{row(Y): board(_,Y,P)} ; player(P).

% opt2: 2 point per settlement on the most self-populated row
% first, defines how many settlements have a player on each row
rowcount(P,Y,H):- H=#count{col(X): board(X,Y,P)} ; domain(_,Y) ; player(P).
score(opt2,P,S*2):- S=#max{T: rowcount(P,Y,T)} ; player(P).

% opt3: 1 point for each settlements next to a Water "W".
score(opt3,P,S):- S={board(X,Y,P): next(X,Y,"W")} ; player(P).

% opt4: 1 point for each settlements next to a Mountain "M".
score(opt4,P,S):- S={board(X,Y,P): next(X,Y,"M")} ; player(P).

% opt5:
%later…

% opt6:
%later…

% opt7: 1 point for each connected component of settlement
% first we need each coord X,Y to be orderable.
% then is defined path/5, that is true iff exists a connected component of settlement of player P
%   that links X,Y to I,J
% then is defined the connected component atom that give the smaller coords in each connected component
% then computing the score.
order(X,Y,Y+X*100):- domain(X,Y).
path(P,X,Y,I,J):- order(X,Y,O1) ; order(I,J,O2) ; O1<O2 ; % order
                  neighbors(X,Y,I,J) ; board(X,Y,P) ; board(I,J,P) ; player(P). % path iff next to
path(P,X,Y,I,J):- order(X,Y,O1) ; order(I,J,O2) ; O1<O2 ; % order
                  path(P,X,Y,K,L) ; neighbors(K,L,I,J) ; % path if path to next to
                  board(I,J,P) ; player(P).
concomp(P,X,Y):- path(P,X,Y,_,_) ; not path(P,_,_,X,Y). % at least two settlements in the connected component
concomp(P,X,Y):- 0 { path(P,X,Y,_,_) ; path(P,_,_,X,Y) } 0 ; board(X,Y,P) ; player(P). % concomp of only one settlements
score(opt7,P,S):- S=#count{concomp(P,X,Y): concomp(P,X,Y)} ; player(P).

% opt8: 0.5 point for each settlement in the bigger connected component
%later…

% total score:
score(total,P,C+S1+S2+S3):- score(core,P,C) ; score(opt1,P,S1) ; score(opt3,P,S2) ; score(opt7,P,S3).

#show.
#show total_score(P,S): score(total,P,S).
%#show score/3. % scores details

