% Box 1: The car is in this box.
% Box 2: The car is not in this box.
% Box 3: The car is not in box 1.
%
% Exactly one is true.
% There is only one car.

1 { p(1;2;3) } 1.
1 { car(1;2;3) } 1.

p(1):- car(1).
p(2):- not car(2).
p(3):- not car(1).
