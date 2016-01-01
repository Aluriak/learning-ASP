%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here is a computation of the best combinations of cards
%  in the board game Seven Wonders.
% In this game, there is 3 types of green cards, representing the technology development.
%  The more green cards a player have, the more point he will scores at the end of the game.
% The 3 types are shelf, wheel and compass, here encoded as s, w and c respectively.
% There is in the vanilla game 5 cards of each type. (see maximal_cards_type constant)
% The points scored are equals to:
%   p = #s^2 + #w^2 + #c^2 + m*7
% With m the minimal number of cards in types.
%
% Example: if you have two cards of each type, minimal is two so the score is 4 + 4 + 4 + 2*7 = 26.
%  If you have three cards for types s and w but only one for c, then m equals to 1,
%   so score is 9 + 9 + 1 + 1*7 = 26.
%
% The aim of this computation is to determine, for a given number of cards,
%  which is the best combination of type to get.
%
% Example: with six cards (cards_number=6) and 4 cards of each type (maximal_cards_type=4),
%  the best solution is to have 2 cards of each type, scoring then 26 points.
%
%
% Runs commands:
%       clingo sevenwonders.lp
%       clingo sevenwonders.lp --const cards_number=6 --const maximal_cards_type=4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define the number of green cards owned, without type consideration,
%  and the maximal number of green cards of each type.
#const cards_number=4.  % there is exactly N cards on the board.
#const maximal_cards_type=5.  % at most N cards of the same type.

% Types are c (compass), s (shelf) and w (wheel).
type(c;s;w).

% Each type is represented by between 0 and N (included) cards.
card_count(0..maximal_cards_type).
1 { cards(Type, Count): card_count(Count) } 1:- type(Type).

% Discard models where there is more or less cards than N.
:- cards_number!=(NC+NS+NW) ; cards(c, NC) ; cards(s, NS) ; cards(w, NW).

% Scores for each type: number of card of this type
score_type(Type, Score):- type(Type) ; cards(Type, Count) ; Score=Count*Count.

% Get the minimal card count for one type.
minimal_card_count(Count):- cards(Type, Count) ; not cards(_, Count2): Count > Count2 , card_count(Count2).

% Scores for triplet: use the minimal number of cards for one type, that gives the number of triplets.
score_triplet(7*Score):- minimal_card_count(Score).

% Final Score is the sum of triplet and type scores
score(Score):- score_triplet(Score_triplet) ;
               score_type(c, Score_c) ; score_type(s, Score_s) ; score_type(w, Score_w) ;
               Score=Score_triplet + Score_c + Score_s + Score_w.

% Maximize the final score
#maximize{S:score(S)}.


% Shows cards repartition and associated final score.
#show.
#show cards/2.
#show score/1.
