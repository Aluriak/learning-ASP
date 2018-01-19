%
% 1: Are both yes and no invalid answers to question 2 ?
% 2: is either yes or no a valid answer to question 1 ?
%
% What is the answer to question 2 ?


q1(yes):- not q2(yes) ; not q2(no).
q1(no):- not q1(yes).
q2(yes):- q1(_).
q2(no):- not q2(yes).
