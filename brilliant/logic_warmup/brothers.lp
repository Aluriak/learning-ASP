% Five brothers, some are taller than other.
sup(alex,brian).
sup(charlie,alex).
sup(daniel,edward).
sup(alex,daniel).

% The tallest is the one that is never lower than another.
tallest(X):- sup(X,_) ; not sup(_,X).

% Will give charlie as the tallest.
