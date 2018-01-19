% MAYBE NOT EASILY DOABLE IN ASP.
% Current implementation do not answers the question.

% Four boxes.
box(1..4).
% Each contain one of
item(apple;banana;carrot;date).
% Only one box is labelled correctly (have the correct item name on it).
% How many box to open to know which one ?

% 1:1 association of boxes and items.
1 { contains(B,I): box(B)  } 1:- item(I).
1 { contains(B,I): item(I) } 1:- box(B).

% 1:1 association of boxes and label.
label(1,apple).
label(2,banana).
label(3,carrot).
label(4,date).

% There is exactly one correct label.
1 { label(B,I): contains(B,I) } 1.
