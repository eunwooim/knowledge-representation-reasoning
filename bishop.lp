{bishop(X,Y)} :- X=1..n, Y=1..n.
:- bishop(X,Y), bishop(X1,Y1), |X-X1|=|Y-Y1|, X!=X1.
#maximize{1,X,Y: bishop(X,Y)}.