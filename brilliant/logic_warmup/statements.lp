%* The puzzle:
%
% 1. There is exactly 1 false statement in this list.
% 2. There are exactly 2 false statements in this list.
% 3. There are exactly 3 false statements in this list.
%
% Exactly how many false statements are there in the list above?
%
*%



% The number of verified statements.
nbp(N):- N={p(_)}.

% There is at most one right.
0{p(1);p(2);p(3)}1.

% the possibilities.
p(1):- nbp(2).
p(2):- nbp(1).
p(3):- nbp(0).

% Note that the puzzle is simple : since all statements are exclusive, only one can be true.
% And if one is true, two are false. The ASP encoding makes this clear.
