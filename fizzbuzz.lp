val(1..100).
div5(X):- val(X) ; X\5=0.
div3(X):- val(X) ; X\3=0.
#show.
#show      val(X): not div5(X) , not div3(X), val(X).
#show     fizz(X): not div5(X) ,     div3(X).
#show     buzz(X):     div5(X) , not div3(X).
#show fizzbuzz(X):     div5(X) ,     div3(X).
