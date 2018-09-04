%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encoding of DSL and problem itself.
% Run with knowledge to solve.
#show.
#show place(X,Y): def_place(X,Y).
#show empty_room(R): empty_room(R), show_empty_rooms.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%*%%%%%%%%%%%%%%%%%%%
% DSL EXPANSION
*%%%%%%%%%%%%%%%%%%%%
boss_of(X,Y):- phd_of(Y,X).
incompatible(X,Y):- friend(X,Y) ; avoid_friendships.
incompatible(X,Y):- boss_of(X,Y) ; avoid_hierarchy.



% humans
human(H):- human(H,_).
human(H,noteam):- human(H) ; not human(H,T): T!=noteam, human(_,T).

% Placement related expansion.
place(H,R):- place_alone(H,R).
place_alone(H):- place_alone(H,_).

% Room related expansions.
def_room((R,N),1):- room(R,NumberOfDesk) ; N=1..NumberOfDesk.
def_room((R,N),1):- room(R,NumberOfDesk,_) ; N=1..NumberOfDesk.
def_room((R,u),1):- room(R) ; not room(R,_).
def_room(R):- def_room(R,_).
% Desk expansion.
def_room((R,D),1):- desk(R,D).
property((R,D),P):- desk(R,D,P).
% Properties expansion.
property((R,N),P):- property(R,P) ; room(R,NumberOfDesk) ; N=1..NumberOfDesk.
property((R,N),P):- room(R,NumberOfDesk,P) ; N=1..NumberOfDesk.
property((R,u),P):- property(R,P) ; room(R) ; not room(R,_).
property((R,D),P):- property(R,D,P).


%*%%%%%%%%%%%%%%%%%%%
% DYNAMIC CHANGES
*%%%%%%%%%%%%%%%%%%%%
% Some humans imply properties in the .
property(R,Prop):- def_place(H,R) ; imply(H,Prop).

%*%%%%%%%%%%%%%%%%%%%
% PLACEMENT GENERATION
*%%%%%%%%%%%%%%%%%%%%
% Each human get a room.
1{def_place(H,R): def_room(R)}1 :- human(H).
% Each room with only one place get a human.
% 1{place(H,R): human(H)}1 :- def_room(R,1).

% Respect limit of human per room.
:- def_room(R,Max) ; {def_place(_,R)}>Max.

% Respect user explicit placements.
:- place(H,R) ; not def_place(H,(R,_)).
:- place(H,R,D) ; not def_place(H,(R,D)).

% avoid incompatibilities between humans
:- incompatible(H1,H2) ; def_place(H1,R) ; def_place(H2,R).
% avoid incompatibilities between human and room
:- incompatible(H,Prop) ; def_place(H,Room) ; property(Room,Prop).
% only one human if alone
:- place_alone(H1) ; def_place(H1,(R,_)) ; def_place(H2,(R,_)) ; H1!=H2.


%*%%%%%%%%%%%%%%%%%%%
% PLACEMENT OPTIMIZATIONS
*%%%%%%%%%%%%%%%%%%%%
empty_room(R):- def_room((R,_),_) ; not def_place(_,(R,_)) ; maximize_desk_state(_).
nb_empty_room(N):- N={empty_room(R)}.
#minimize{N:nb_empty_room(N),maximize_desk_state(occupied)}.
#maximize{N:nb_empty_room(N),maximize_desk_state(empty)}.


%*%%%%%%%%%%%%%%%%%%%
% TEAM OPTIMIZATIONS
*%%%%%%%%%%%%%%%%%%%%
optimize_team_mixing.  % Delete to ignore teams.
