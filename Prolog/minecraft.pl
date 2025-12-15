jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

tieneItem(Persona,Item):-
    jugador(Persona, ListaItem,_),
    member(Item, ListaItem).

sePreocupaPorSuSalud(Persona):-
    comestible(Comestible1),
    tieneItem(Persona,Comestible1),
    comestible(Comestible2),
    tieneItem(Persona,Comestible2),
    Comestible1 \= Comestible2.

cantidadDeItem(Persona,Item,Cantidad):-
    existeItem(Item),
    findall(Item,tieneItem(Persona,Item),ListaItems),
    length(ListaItems,Cantidad).

existeItem(Item) :-
    tieneItem(_, Item).

tieneMasDe(Persona, Item) :-
    jugador(Persona, _, _),
    cantidadDeItem(Persona, Item, Cant),
    Cant > 0,
    forall((jugador(OtraPersona, _, _), OtraPersona \= Persona), otraCantidad(Persona,Cant)).

otraCantidad(OtraPersona, Cant):-
    cantidadDeItem(OtraPersona, Item, OtraCant),
    Cant >= OtraCant.



%2)

hayMonstruos(Lugar):-
    lugar(Lugar,_,NivelOscuridad),
    NivelOscuridad > 6.

correPeligro(Lugar):-
    jugador(Persona, _, _),
    habita(Persona,Lugar),
    hayMonstruos(Lugar).

correPeligro(Lugar):-
    jugador(Persona,_ ,Hambre),
    estaHambriento(Persona,Hambre),
    not(tieneItemComestible(Persona)).

estaHambriento(_,Hambre):-
    Hambre < 4.

tieneItemComestible(Persona):-
    jugador(Persona,ListaItems,_),
    member(ItemComestible,ListaItems),
    comestible(ItemComestible).

habita(Persona,Lugar):-
    jugador(Persona, _, _),
    lugar(Lugar, ListaPersonas, _),
    member(Persona,ListaPersonas).

nivelDePeligrosidad(Lugar, NivelPeligroso):-
    findall(Persona, habita(Persona,Lugar), ListaPoblacion),
    length(ListaPoblacion,CantPoblacion),
    findall(Persona, (habita(Persona, Lugar), estaHambriento(Persona,_)), ListaHambrientos),
    length(ListaHambrientos, CantHambrientos),
    NivelPeligroso is (CantHambrientos / CantPoblacion).


nivelDePeligrosidad(Lugar, NivelPeligroso):-
    hayMonstruos(Lugar),
    NivelPeligroso is 100.

nivelDePeligrosidad(Lugar,NivelPeligroso):-
    lugar(Lugar,_, NivelOscuridad),
    not(habita(_,Lugar)),
    NivelPeligroso is (NivelOscuridad * 10).
    
item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).

% Caso general: un jugador puede construir un Item si cumple todos los requisitos
puedeConstruir(Persona, Item) :-
    item(Item, Reqs),
    forall(member(Req, Reqs), cumpleReq(Persona, Req)).

% Caso 1: Requisito de ítem simple con cantidad
cumpleReq(Persona, itemSimple(ItemSimple, Cantidad)) :-
    personaje(Persona, ListaItems, _),
    findall(ItemSimple, member(ItemSimple, ListaItems), ListaFiltrada),
    length(ListaFiltrada, CantidadQueTiene),
    CantidadQueTiene >= Cantidad.







    