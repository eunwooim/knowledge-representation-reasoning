%% Legacy configuration
person(P) :- legacyConfig(person(P)).
thing(T) :- legacyConfig(thing(T)).
owns(P,T) :- legacyConfig(personTOthing(P,T)).

%% Ownership constraints (1,6)
:- cabinetTOthing(C,T1), cabinetTOthing(C,T2), owns(P1,T1), owns(P2,T2), P1 != P2.

%% Ownership constraints (3)
:- roomTOcabinet(R,C1), roomTOcabinet(R,C2), C1 != C2.

%% Cabinets can hold up to 5 things (2)
:- cabinetTOthing(C,T1), cabinetTOthing(C,T2), T1 != T2, #count{T: cabinetTOthing(C,T)} > 5.

%% Rooms can hold up to 4 cabinets (4)
:- roomTOcabinet(R,C1), roomTOcabinet(R,C2), C1 != C2, #sum{
    1,C: roomTOcabinet(R,C), cabinetSmall(C); 2,C: roomTOcabinet(R,C), cabinetHigh(C)} > 4.

%% Ownership constraints (5)
:- cabinet(C), thing(T), not cabinetTOthing(C,T), #sum{1,C: cabinetTOthing(C,T)} > 3.

%% Cabinet to things, room to cabinets
{cabinetTOthing(C,T): cabinet(C)}=1 :- legacyConfig(thing(T)).
{roomTOcabinet(R,C): room(R)}=1 :- cabinet(C).

%% Legacy configuration
{cabinet(C): legacyConfig(cabinet(C)); cabinet(C): cabinetDomainNew(C)}.
{room(R): legacyConfig(room(R)); room(R): roomDomainNew(R)}.

%% Categorize legacy things into short and long things
thingShort(T) :- legacyConfig(thing(T)), not thingLong(T).

%% Categorize cabinets into small and high
{cabinetSmall(C); cabinetHigh(C)}=1 :- cabinet(C).

%% Long items must go in high cabinets
:- thingLong(T), cabinetTOthing(C,T), not cabinetHigh(C).

% Optimization, weighted sum of the cost by @
#minimize{
    3@1,C: cabinetHigh(C), legacyConfig(cabinet(C));
    2@1,C,T: not cabinetTOthing(C,T), legacyConfig(cabinetTOthing(C,T));
    2@1,R,C: not roomTOcabinet(R,C), legacyConfig(roomTOcabinet(R,C));
    2@1,R,C: not roomTOcabinet(R,C), legacyConfig(roomTOcabinet(R,C));
    2@1,C: not cabinet(C), legacyConfig(cabinet(C));
    5@1,R: room(R), not legacyConfig(room(R));
    10@1,C: cabinet(C), not legacyConfig(cabinet(C)), cabinetHigh(C);
    100@1,C: cabinet(C), not legacyConfig(cabinet(C)), cabinetHigh(C);
    5@1,R: room(R), not legacyConfig(room(R))
}.

% Output
#show cabinet/1.
#show room/1.
#show cabinetTOthing/2.
#show roomTOcabinet/2.
#show cabinetHigh/1.
#show cabinetSmall/1.
