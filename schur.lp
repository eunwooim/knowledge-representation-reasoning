% Partition {1,..,n} into k sum-free sets

% input: positive integers n, k.

% partition set {1,...,n} into k subsets in (I,S) means number I is in set set
{in(I,1..k)} = 1 :- I=1..n.

% these subsets are sum-free.
:- in(I,S), in(J,S), in(I+J,S).

% Command: clingo schur.lp -c k=3 -c n=12
