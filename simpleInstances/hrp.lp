{cabinet(C)} :- cabinetDomain(C).
{room(R)} :- roomDomain(R).
room(R1) :- roomDomain(R1), roomDomain(R2), room(R2), R1<R2.
cabinet(C1) :- cabinetDomain(C1), cabinetDomain(C2), cabinet(C2), C1<C2.

{cabinetTOthing(C,T)} :- cabinetDomain(C), thing(T).
thingHasCabinet(T) :- cabinetTOthing(C,T).
:- thing(T), not thingHasCabinet(T).
:- thing(T), cabinetDomain(C1), cabinetTOthing(C1,T), cabinetDomain(C2), cabinetTOthing(C2,T), C1<C2.
:- 6 <= #count{T: cabinetTOthing(C,T), thing(T)}, cabinet(C).

{roomTOcabinet(R,C)} :- roomDomain(R), cabinet(C).
cabinetHasRoom(C) :- roomTOcabinet(R,C).
:- cabinet(C), not cabinetHasRoom(C).
:- cabinet(C), roomDomain(R1), roomTOcabinet(R1,C), roomDomain(R2), roomTOcabinet(R2,C), R1<R2.
:- 5 <= #count{C: roomTOcabinet(R,C), cabinetDomain(C)}, room(R).

personTOroom(P,R) :- personTOthing(P,T), cabinetTOthing(C,T), roomTOcabinet(R,C).
:- personTOroom(P1,R), personTOroom(P2,R), P1<P2.

room(R) :- roomTOcabinet(R,C).
room(R) :- personTOroom(P,R).
cabinet(C) :- cabinetTOthing(C,T).
cabinet(C) :- roomTOcabinet(R,C).
thing(T) :- personTOthing(P,T).


%totalCost(N) :- N=#sum{}.
%#minimize{N: totalCost(N)}.