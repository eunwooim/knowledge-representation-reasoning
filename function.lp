domain(1;2;3).
codomain(a;b).

% Assign Y for local and X for global variable
{f(X,Y): codomain(Y)}=1 :- domain(X).

#show f/2.

% Command: clingo function.lp 0
