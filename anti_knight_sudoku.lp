1 {a(X,Y,N):X=1..9,Y=1..9,X1<=X,X<=X1+2,Y1<=Y,Y<=Y1+2} 1
:- N=1..9, X1=3*(0..2)+1, Y1=3*(0..2)+1.

:- a(X,Y,N), a(X,Y,N1), N!=N1.
:- a(X,Y,N), a(X,Y1,N), Y!=Y1.
:- a(X,Y,N), a(X1,Y,N), X!=X1.
:- a(X,Y,N), a(X1,Y1,N), |X1-X|+|Y1-Y|==3.

a(1,1,3). a(1,9,9). a(2,4,8). a(2,6,1). a(3,3,6). a(3,7,7). a(4,2,6). a(4,4,3). a(4,6,8). a(4,8,7). a(5,5,7). a(6,2,9). a(6,4,2). a(6,6,5). a(6,8,8). a(7,3,9). a(7,7,8). a(8,4,6). a(8,6,7). a(9,1,4). a(9,9,7).