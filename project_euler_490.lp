% Project Euler, problem 490.
%
% https://projecteuler.net/problem=490

% usage:
%  clingo -n 0 project_euler_490.lp -c nb_stone=6
%  clingo -n 0 project_euler_490.lp -c nb_stone=10 -c max_jump=4 --parallel-mode=4
%  clingo -n 0 project_euler_490.lp -c nb_stone=20 >> out   # got 453355 answer sets, in 30s
%
% Use  --parallel-mode=4 to speed up things a little.


% Number of stone
#const nb_stone=6.
stone(1..nb_stone).
% Maximal number of stone the frog can bypass
#const max_jump=3.
% Minimal counterpart
#const min_jump=1.


% An acceptable jump is bounded by min and max.
ok_jump(min_jump..max_jump).
ok_jump(-max_jump..-min_jump).

% The frog start at stone 1, and finish on the last stone.
step(1,1).
step(nb_stone,nb_stone).

% At step I, the frog is on a single stone, at a jump distance of the previous one.
1 { step(I,S): step(J,PrevS), stone(S), ok_jump(S-PrevS) } 1:- I=J+1 ; step(J,_) ; stone(I).

% The frog do not want to go two times on the same stone.
:- step(I,S) ; step(J,S) ; I!=J.
% The frog have to visit each stone.
:- stone(S) ; not step(_,S).

% Don't show anything, we just want the number of stable model.
#show.
% #show step/2.  % uncomment if you want to see the paths.
