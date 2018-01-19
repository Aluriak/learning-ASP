% Knights always tell the truth. Knaves always lie. Joker can do either.

% 3 agents knows themselves, and say:
%  - ellis: farin is a joker
%  - farin: gobi is a joker
%  - gobi: ellis is a joker
% There is only one joker. How many knights ?

% Data.
kind(knight;knave;joker).
ppl(ellis;farin;gobi).

% Each one has a kind.
1 { kind(P,K): kind(K) } 1:- ppl(P).

% There is one and only one joker.
1 { kind(P,joker):ppl(P) } 1.

% Number of knight.
answer(N):- N={kind(_,knight)}.

% A knight always imply the thruth.
kind(farin,joker):- kind(ellis,knight).
kind(gobi,joker):- kind(farin,knight).
kind(ellis,joker):- kind(gobi,knight).

% Knaves can't tell the truth.
:- kind(farin,joker) ; kind(ellis,knave).
:- kind(gobi,joker) ; kind(farin,knave).
:- kind(ellis,joker) ; kind(gobi,knave).

% NB: the three generated answer sets all say there is 1 knight.
% Additionnal constraints are therefore not necessary.
