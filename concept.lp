% Extracting formal concepts from a formal context.
% This do not scale well.


% The context used is the following.
                   %   f g h i j k
rel(a,(f;g)).      % a × ×
rel(b,(g;h;j;k)).  % b   × ×   × ×
rel(c,(i;j;k)).    % c       × × ×
rel(d,(g;i)).      % d   ×   ×
rel(e,(f;g;h;i)).  % e × × × ×

% 9 concepts are found in this context:
% a e × f g
% a b d e × g
% b × g h j k
% c × i j k
% b c × j k
% c d e × i
% d e × g i
% e × f g h i
% b e × g h

% Each of these concepts will be generated in its own answer set with the following code.


% X is an object if in relation with all attributes.
obj(X):- rel(X,_) ; rel(X,Y): att(Y).
% Y is an attribute if in relation with all objects.
att(Y):- rel(_,Y) ; rel(X,Y): obj(X).

% Avoid answer sets containing no objects.
:- not obj(X):obj(X).
% Avoid answer sets containing no attributes.
:- not att(Y):att(Y).


#show.
#show obj/1.
#show att/1.
