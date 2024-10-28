{in(I,1..k)} = 1 :- I=1..n.

:- in(I,S), in(J,S), in(I+J,S), I!=J.

% Command: clingo almost_schur.lp -c k=4 -c n=66
