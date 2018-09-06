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
stair(1,100).  % uid, size
stair(2,50).
stair(3,150).
stair(4,120).


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
