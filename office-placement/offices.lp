%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Evident knowledge for offices.
% The DSL defined by engine.lp can be used here.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% define rooms with room(name, number of places/desks).
room(a100,2).
room(a101).  % default number of place is 1
room(a102,2).


% Note that you can also work per place in rooms:
desk(a103,a).  % desk A in room a103 can hold a human
desk(a103,b,sunny).  % idem for desk B, but with the property sunny
% so now, you can say that only one of the desk in room a103 hold specific properties:
property(a103,a,(near_radiator;no_outlet)).
