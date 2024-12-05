%% Legacy configuration
cabinetDomain(X) :- cabinetDomainNew(X).
roomDomain(X) :- roomDomainNew(X).

% Lower, upper limit of cabinets constraint
cabinetLower{cabinet(X): cabinetDomain(X)} cabinetUpper.
roomLower{room(X): roomDomain(X)} roomUpper.

% Ordering of used cabinets and rooms
room(X) :- roomDomainNew(X), roomDomainNew(Y), room(Y), X<Y.
cabinet(X) :- cabinetDomainNew(X), cabinetDomainNew(Y), cabinet(Y), X<Y.

%% Cabinets can hold up to 5 things
1 {cabientTOthing(X,Y): cabinetDomain(X)}1 :- thing(Y).
:- 6{cabinetTothing(X,Y): thing(Y)}, cabinet(X).

%% Rooms can hold up to 4 cabinets
1{roomTOcabinet(X,Y): roomDomain(X)}1 :- cabinet(Y).
:- 5{roomTOcabinet(X,Y): cabinetDomain(Y)}, room(X).

%% A person owns a room, with one's things in cabinets
personTOroom(P,R) :- personTOthing(P,X), cabinetTOthing(C,X), roomTOcabinet(R,C).

%% Cabinet can hold only one's things
:- cabinetTOthing(X,Y1), cabinetTOthing(X,Y2), personTOthing(P1,Y1), personTOthing(P2,Y2), P1!=P2.
:- personTOroom(P1,R), personTOroom(P2,R), P1!=P2.

%% Cabinets can belong to an unique room
room(X) :- roomTOcabinet(X,Y).
room(Y) :- personTOroom(X,Y).
cabinet(X) :- cabinetTOthing(X,Y).
cabient(Y) :- roomTOcabinet(X,Y).

%% Things can be either Long or Small
thing(X) :- thingLong(X).
thing(X) :- thingSmall(X).
:- thingLong(X), thingSmall(X).

% Long things are in Long cabinets
1{cabinetLong(X); cabinetSmall(X)}1 :- cabinet(X).
cabinetLong(C) :- thingLong(X), cabinetTothing(C,X).

% Cabinet can hold 4 slots
% cabinetSize(X,1) :- cabinet(X), cabinetSmall(X).
% cabinetSize(X,2) :- cabinet(X), cabinetLong(X).
% roomTOcabinetSlot(R,C,S) : - roomTOcabinet(R,C), cabinetSize(C,S).
% :- 5 {roomTOcabinetSlot(X,Y,S) : cabinetDomain(Y)=S}, room(X).

% HRP
person(X) : - legacyConfig(person(X)).
thing(X) : - legacyConfig(thing(X)).
personTOthing(X,Y) : - legacyConfig(personTOthing(X,Y)).
1 {reuse(cabinetTOthing(X,Y)); delete(cabinetTOthing(X,Y))}1 :- legacyConfig(cabinetTOthing(X,Y)).
1 {reuse(roomTOcabinet(X,Y)); delete(roomTOcabinet(X,Y))}1 :- legacyConfig(roomTOcabinet(X,Y)).
1 {reuse(personTOroom(X,Y)); delete(personTOroom(X,Y))}1 :- legacyConfig(personTOroom(X,Y)).

%% Legacy cabinets to new domain
cabinetDomain(X) :- legacyConfig(cabinet(X)).
1 {reuse(cabinet(X)); delete(cabinet(X))}1 :- legacyConfig(cabinet(X)).

%% Legacy rooms to new domain
roomDomain(X) :- legacyConfig(room(X)).
1 {reuse(room(X)); delete(room(X))}1 :- legacyConfig(room(X)).

% Keep the reused objects
cabinetTOthing(X,Y) :- reuse(cabinetTOthing(X,Y)).
roomTOcabinet(X,Y) :- reuse(roomTOcabinet(X,Y)).
personTOroom(X,Y) :- reuse(personTOroom(X,Y)).
cabinet(X) :- reuse(cabinet(X)).
room(X) :- reuse(room(X)).

% Removed objects cannot be used
:- cabinetTOthing(X,Y), delete(cabinetTOthing(X,Y)).
:- roomTOcabinet(X,Y), delete(roomTOcabinet(X,Y)).
:- personTOroom(X,Y), delete(personTOroom(X,Y)).
:- cabinet(X), delete(cabinet(X)).
:- room(X), delete(room(X)).

% Costs
cost(create(cabinetLong(X)),W) :- cabinetLong(X), cabinetLongCost(W), cabinetDomainNew(X).
cost(create(cabinetSmall(X)),W) :- cabinetSmall(X), cabinetSmallCost(W), cabinetDomainNew(X).
cost(create(room(X)),W) :- room(X), roomCost(W), roomDomainNew(X).

% OPTIMIZATION
% Minimize reconfiguration costs
#minimize{X,W: cost(X,W)}.

#show cabinetTOthing/2.
#show roomTOcabinet/2.
#show cabinet/1.
#show room/1.