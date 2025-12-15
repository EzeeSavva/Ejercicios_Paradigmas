anioActual(2015).


%festival(nombre, lugar, bandas, precioBase).

%lugar(nombre, capacidad).

%festival(nombre, lugar, bandas, precioBase).

festival(lulapaluza, lugar(hipodromo,40000), [miranda, paulMasCarne, muse], 500).

festival(mostrosDelRock, lugar(granRex, 10000), [kiss, judasPriest, blackSabbath], 1000).

festival(personalFest, lugar(geba, 5000), [tanBionica, miranda, muse, pharrellWilliams], 300).

festival(cosquinRock, lugar(aerodromo, 2500), [erucaSativa, laRenga], 400).


%banda(nombre, año, nacionalidad, popularidad).

banda(paulMasCarne,1960, uk, 70).

banda(muse,1994, uk, 45).

banda(kiss,1973, us, 63).

banda(erucaSativa,2007, ar, 60).

banda(judasPriest,1969, uk, 91).

banda(tanBionica,2012, ar, 71).

banda(miranda,2001, ar, 38).

banda(laRenga,1988, ar, 70).

banda(blackSabbath,1968, uk, 96).

banda(pharrellWilliams,2014, us, 85).


%entradasVendidas(nombreDelFestival, tipoDeEntrada, cantidadVendida).

% tipos de entrada: campo, plateaNumerada(numero de fila), plateaGeneral(zona).


entradasVendidas(lulapaluza,campo, 600).

entradasVendidas(lulapaluza,plateaGeneral(zona1), 200).

entradasVendidas(lulapaluza,plateaGeneral(zona2), 300).


entradasVendidas(mostrosDelRock,campo,20000).

entradasVendidas(mostrosDelRock,plateaNumerada(1),40).

entradasVendidas(mostrosDelRock,plateaNumerada(2),0).

% … y asi para todas las filas

entradasVendidas(mostrosDelRock,plateaNumerada(10),25).

entradasVendidas(mostrosDelRock,plateaGeneral(zona1),300).

entradasVendidas(mostrosDelRock,plateaGeneral(zona2),500).


plusZona(hipodromo, zona1, 55).

plusZona(hipodromo, zona2, 20).

plusZona(granRex, zona1, 45).

plusZona(granRex, zona2, 30).

plusZona(aerodromo, zona1, 25).


estaDeModa(Banda):-
    banda(Banda,Anio,_,Popularidad),
    between(2010, 2015, Anio),
    Popularidad > 70.

esCareta(Festival):-
    festival(Festival,_,ListaBandas,_),
    hayDosBandasDeModa(ListaBandas).

esCareta(Festival):-
    festival(Festival,lugar(Campo,CantPersonas),_,_),
    noTengaEntradasRazonables(Festival, lugar(Campo, CantPersonas)).

esCareta(Festival):-
    festival(Festival,_,ListaBandas,_),
    member(miranda, ListaBandas).


hayDosBandasDeModa(ListaBandas) :-
    member(Banda1, Bandas),
    member(Banda2, Bandas),
    Banda1 \= Banda2,
    estaDeModa(Banda1),
    estaDeModa(Banda2).

noTengaEntradasRazonables(Festival, lugar(Campo, CantPersonas)) :-
    not (entradaRazonable(Festival, campo)),
    not (entradaRazonable(Festival, plateaGeneral(_))),
    not (entradaRazonable(Festival, plateaNumerada(_))).

entradaRazonable(Festival, campo) :-
    festival(Festival, _, Bandas, PrecioBase),
    precioCampo(PrecioBase, PrecioCampo),
    popularidadTotal(Bandas, PopTotal),
    PrecioCampo < PopTotal.

entradaRazonable(Festival, plateaGeneral(Zona)) :-
    festival(Festival, _, _, PrecioBase),
    plusZona(Zona, _, Plus),
    precioPlateaGeneral(PrecioBase, Plus, PrecioGeneral),
    PrecioGeneral < PrecioBase * 1.1.   % menos del 10% extra

entradaRazonable(Festival, plateaNumerada(Fila)) :-
    festival(Festival, lugar(_, Capacidad), Bandas, PrecioBase),
    precioPlateaNumerada(PrecioBase, Fila, PrecioNumerada),
    ningunaDeModa(Bandas), 
    PrecioNumerada =< 750.

entradaRazonable(Festival, plateaNumerada(Fila)) :-
        algunaDeModa(Bandas), 
         popularidadTotal(Bandas, PopTotal),
         PrecioNumerada < (Capacidad / PopTotal).

precioCampo(PrecioBase, PrecioCampo) :-
    PrecioCampo is PrecioBase.

precioPlateaGeneral(PrecioBase, Plus, PrecioGeneral) :-
    PrecioGeneral is PrecioBase + Plus.

precioPlateaNumerada(PrecioBase, Fila, PrecioNumerada) :-
    PrecioNumerada is PrecioBase + 200 / Fila.


popularidadTotal(Bandas, PopTotal) :-
    findall(Pop, (member(B, Bandas), banda(B, _, _, Pop)), Pops),
    sum_list(Pops, PopTotal).

ningunaDeModa(Bandas) :-
    \+ (member(B, Bandas), estaDeModa(B)).

algunaDeModa(Bandas) :-
    member(B, Bandas),
    estaDeModa(B).





%festival(nombre, lugar, bandas, precioBase).

festival(lulapaluza, lugar(hipodromo,40000), [miranda, paulMasCarne, muse], 500).

entradasVendidas(mostrosDelRock,plateaGeneral(zona1),300).

banda(paulMasCarne,1960, uk, 70).
