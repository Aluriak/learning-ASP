%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evident knowledge for humans.
% The DSL defined by engine.lp can be used here.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Knowledge.
human(agnan,team_01).
human((marie_edwige;nicolas;clotaire),team_02).

% Specific placement.
place_alone(agnan,a100).  % equivalent to `place_alone(agnan). place(agnan,a124).`

% Examples of rules.
incompatible(marie_edwige,nicolas).  % can't be placed in the same office.
friend(nicolas,clotaire).  % equivalent to incompatible/2 if `avoid_friendships` is set.
phd_of(nicolas,agnan).  % equivalent to incompatible/2 if `avoid_hierarchy` is set.

% Office preference and implication on office attributes.
preference(nicolas,cold).  % nicolas prefers cold
imply(nicolas,cold).  % nicolas always open the window, even in winter.
imply(clotaire,noisy).  % clotaire is noisy
incompatible(clotaire,(sunny;cold)).  % clotaire is a vampire, and fears the cold


% Solving options.
optimize_team_mixing.  % Delete to ignore teams.
% avoid_friendships.  % Uncomment to prevent friends to be together.
avoid_hierarchy.  % Delete to let bosses be in the same.

% If set, the following option will optimize, depending of its argument:
%   - empty: the number of empty rooms
%   - occupied: the number of occupied rooms
maximize_desk_state(occupied).

% Output options.
show_empty_rooms.  % Delete to avoid empty_room/1 in output.
