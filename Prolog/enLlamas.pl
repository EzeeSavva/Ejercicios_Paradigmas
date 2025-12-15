tieneFoco(rosario, 20). 
tieneFoco(cosquín, 50). 
tieneFoco(km607, 300). 

lugar(rosario, ciudad(500)). 
lugar(cosquin, pueblo(20)). 
lugar(km607, campo).

provincia(rosario, santaFe). 
provincia(cosquin, cordoba).

%1.
tienenFocosParecidos(UnLugar, OtroLugar):-
    tieneFoco(UnLugar, Tamanio),
    tieneFoco(OtroLugar, OtroTamanio),
    UnLugar /= OtroLugar,
    abs(Tamanio - OtroTamanio) < 5.

%2.

tieneFocoGrave(UnLugar):-
    tieneFoco(UnLugar, Tamanio),
    Tamanio > 100.

tieneFocoGrave(UnLugar):-
    tieneFoco(UnLugar, Tamanio),
    Tamanio > 20,
    esPoblado(UnLugar).

esPoblado(UnLugar):-
    lugar(UnLugar, ciudad(_)).

esPoblado(UnLugar):-
    lugar(UnLugar, pueblo(Cantidad)),
    Cantidad > 200.

%3.
buenPronostico(UnLugar):-
    not tieneFocoGrave(UnLugar),

    forall(cercanos(UnLugar, Cercano), \+ tieneFocoGrave(Cercano)).

%4.
provinciaComprometida(Provincia):-
    findall(Lugar,(provincia(UnLugar, Provincia),tieneFoco(UnLugar, _)), ListaFocosIncendio),
    length(CantidadFocosIncendio, ListaFocosIncendio),
    CantidadFocosIncendio > 4.


%5.

provinciaAlHorno(Provincia):-
    provinciaComprometida(Provincia),
    forall((provincia(UnLugar,Provincia)tieneFoco(UnLugar, _)), tieneFocoGrave(UnLugar)).

provinciaAlHorno(Provincia):-
    forall(provincia(Lugar, Provincia),tieneFoco(Lugar, _)).










