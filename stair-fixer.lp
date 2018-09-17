% Stair fixer.
% We have `maxboards` wood boards of `board_length` centimeters.
% Atom `stair(N,C)` indicate we have a stair N to fix by adding a piece of C centimeters of wood.
% Question: how to cut the wood boards to get all the pieces, while avoiding using too much boards, and prevent waste by minimizing the unused remainings ?
% Answer(s):
%  clingo 0 stair-fixer.lp
%  (add --opt-mode=optN to get all optimal models)
%  (constants can be changed with -c maxboards=6 for instance)
% Note: it's basically a knapsack problem.
#show.
#show total_diff/1.
#show cutinboard(L,S): usefor(L,S).

#const maxboards=3.
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



% Define how many boards to use.
0{subset(1)}1.
0{subset(N+1)}1:- subset(N) ; N<maxboards.

% Assign each stair to a board.
1{usefor(L,S): subset(S)}1 :- stair(L,_).

% Compute the total used size of the board and prevent using more than available.
subset_size(S,Z):- Z=#sum{Cm: stair(L,Cm), usefor(L,S)} ; subset(S).
:- subset_size(_,Z) ; Z>board_length.

% Minimize the remainings of the used boards.
diff_size(S,D):- subset_size(S,Z) ; D=board_length-Z.
total_diff(T):- T=#sum{D: diff_size(_,D)}.
#minimize{D:total_diff(D)}.
