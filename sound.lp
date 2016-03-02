% connected rooms
next_room(0,9).
next_room(7,(0;1;2;3;8;12;13)).
next_room(8,(9;11)).
next_room(10,(9;11)).
next_room(11,(10;12)).
next_room(6,(3;13;5)).
next_room(4,(3;5)).

% the link is commutative
next_room(X,Y):- next_room(Y,X).

% there is a noisy sound in the room 10
sound(10,10).

% room next to noisy rooms are noisy too
sound(X,Level-1):- sound(Y,Level) ; next_room(X,Y) ; Level >= 0.

% get the max sound in each room
max_sound(X,L):- sound(X,L) ; not sound(X,L2): L2 > L, sound(X,L2).

% printings
#show.
#show max_sound/2.
