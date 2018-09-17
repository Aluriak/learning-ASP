% Stair fixer.
% We have `maxboards` wood boards of `board_length` centimeters.
% Atom `stair(N,C)` indicate we have a stair N to fix by adding a piece of C centimeters of wood.
% Question: how to cut the wood boards to get all the pieces, while avoiding using too much boards, and prevent waste by minimizing the unused remainings ?
% Answer(s):
%  clingo 0 stair-fixer.lp
%  (add --opt-mode=optN to get all optimal models)
%  (constants can be changed with -c maxboards=6 for instance)
% Note: it's basically a knapsack problem.

% Question : how much this program saved us wood ?
%  Answer can be given by a program simulating a human approach: find some 2 or 3-uplet of stairs that together are equal or close to board size. Cut them.
%  Repeat until no uplet exists. Cut remainings in other boards in a greedy approach.

#show.
#show setsize(S,Z): subset_size(S,Z).
#show cutinboard(L,S): usefor(L,S).
#show nb_boards/1.
#show diff_size/2.
#show total_diff/1.
% #show minimal_board_number/1.

% Maximal number of boards to use
% NOTE: an initial safe number is 34, the number of stairs.
% NOTE: manual multi-shot solving narrow solution to at most 9 boards.
% NOTE: run with 8 will yield no model in 1 hour of search, suggesting that this instance is not solvable with only 8 boards.
#const maxboards=9.
#const board_length=250.

% Data, giving the size of each stair uid.
stair(1,81).  % uid, size
stair(2,76).
stair(3,76).
stair(4,77).
stair(5,78).
stair(6,79).
stair(7,83).
stair(8,85).
stair(9,88).
stair(10,86).
stair(11,74).
stair(12,73).
stair(13,79).
stair(14,92).
stair(15,107).
stair(16,92).
stair(17,78).
stair(18,80).
stair(19,84).
stair(20,81).
stair(21,89).
stair(22,101).
stair(23,121).
stair(24,92).
stair(25,83).
stair(26,79).
stair(27,71).
stair(28,66).
stair(29,71).
stair(30,82).
stair(31,111).
stair(32,106).
stair(33,86).
stair(34,82).

% Determine how many boards needs to be used.
total_stair_size(Z):- Z=#sum{Cm: stair(_,Cm)}.
minimal_board_number(B)  :- total_stair_size(Z) ; B = Z / board_length ; 0=Z\board_length.
minimal_board_number(B+1):- total_stair_size(Z) ; B = Z / board_length ; 0<Z\board_length.

% Determine the maximal number of stair one can cut in a single board.
max_stair_per_board(Min):- Size=#min{L:stair(_,L)} ; Min=1+board_length/Size.  % 4 in this instance

% Define how many boards to use.
1{nb_boards(B..maxboards)}1 :- minimal_board_number(B).
subset(1..X):- nb_boards(X).
#minimize{B:nb_boards(B)}.

% Assign each stair to a board.
1 { usefor(L,S): subset(S) } 1 :- stair(L,_).
% Assign at most 4 stairs to each board.
1 { usefor(L,S): stair(L,_) } MS :- subset(S) ; max_stair_per_board(MS).

% Compute the total used size of the board and prevent using more than available.
subset_size(S,Z):- subset(S) ; Z=#sum{Cm: stair(L,Cm), usefor(L,S)}.
:- subset_size(_,Z) ; Z>board_length.

% Minimize the remainings of the used boards.
%  Will explode memory, especially total_diff/1.
%  See https://lucas.bourneuf.net/blog/asp-encodings.html for explanations
diff_size(S,D):- subset_size(S,Z) ; D=board_length-Z.
#minimize{D,S: diff_size(S,D)}.
% total_diff(T):- T=#sum{D: diff_size(_,D)}.
% #minimize{D,2: total_diff(D)}.
