% block(1..6).
% initial state
% :- not on(1,2,0; 2,table,0; 3,4,0; 4,table,0; 5,6,0; 6,table,0).
% goal
% :- not on(3,2,m; 2,1,m; 1,table,m; 6,5,m; 5,4,m; 4,table,m).

block(a;b;c;d;e;f;g;h;i;j;k;l;m;n;o).

% initial state
:- not on(m,table,0; l,m,0; a,l,0; b,a,0; c,b,0; o,table,0; n,o,0; d,n,0; e,d,0; j,e,0; k,j,0; f,table,0; g,f,0; h,g,0; i,h,0).

% max step
:- not on(e,j,m; a,e,m; n,a,m; i,d,m; h,i,m; m,h,m; o,m,m; k,g,m; c,k,m; b,c,m; l,b,m).