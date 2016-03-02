val(1..100).
div5(X):- val(X) ; val(Y) ; 5*Y=X.
div3(X):- val(X) ; val(Y) ; 3*Y=X.
#show     fizz(X): not div5(X) ,     div3(X).
#show     buzz(X):     div5(X) , not div3(X).
#show fizzbuzz(X):     div5(X) ,     div3(X).