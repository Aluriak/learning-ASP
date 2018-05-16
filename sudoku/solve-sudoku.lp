% data: already set marks
% s(X,Y,V) -> value V for square in row X and column Y.
% see examples/ for data examples
% row(1..3).
% col(1..3).

% encoding
val(1..9).
border(1;4;7).

% One number per square
1 {s(R,C,V): val(V) } 1:- val(R) ; val(C).
% One number per row
1 {s(R,C,V): val(R) } 1:- val(C) ; val(V).
% One number per column
1 {s(R,C,V): val(C) } 1:- val(R) ; val(V).

% One number per sub-grid
1 { s(R,C,V):
   val(R), val(C),
   R1<=R, R<=(R1+2),
   C1<=C, C<=(C1+2)
} 1 :- val(V) ; border(R1) ; border(C1).


#show s/3.
