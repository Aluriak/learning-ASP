% Knights always tell the truth. Knaves always lie. Joker can do either.
% What is an agent saying «i'm a knave» ?

% It's one of the three.
1 {knight ; knave ; joker} 1.

% What can be said depending of the kind.
say(knight):- knight.
say(knight) ; say(joker):- knave.
say(knight) ; say(knave) ; say(joker):- joker.

% We know it said it was a knave, so it has to be in the answer.
:- not say(knave).
