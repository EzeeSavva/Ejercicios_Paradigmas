vive(juan, casa(120)).
vive(nico, ambiente(3,2)).
vive(alf, ambiente(3,1)).
vive(julian, loft(2000)).
vive(fer, casa(110)).
vive(vale, ambiente(4, 1)).
barrio(juan,almagro).
barrio(alf, almagro).
barrio(nico,almagro).
barrio(julian, almagro).
seQuiereMudar(rocio, casa(90)).
barrio(vale, flores).
barrio(fer, flores).


esCopada(casa(Metros)):- Metros > 100.

esCopada(loft(Anio)):- Anio > 2015.

esCopada(ambiente(Ambientes, _)):- Ambientes > 3.

esCopada(ambiente(_, Banios)):- Banios > 1.

todosVivenEnBarrioCopado(Barrio):-
    barrio(_,Barrio),
    forall(barrio(Persona,Barrio), viveEnBarrioCopado(Persona,Barrio)).
    
viveEnBarrioCopado(Persona, Barrio):-
    vive(Persona, Propiedad),
    esCopada(Propiedad).

esCaro(Barrio):-
    barrio(_,Barrio),
    forall((barrio(Persona,Barrio),vive(Persona, Propiedad)), not(esBarata(Propiedad))).

esBarata(casa(Metros)):- Metros < 90.

esBarata(loft(Anio)):- Anio < 2005.

esBarata(ambiente(Ambientes,_)):- between(1, 2, Ambientes).

valorCasa(juan, 150000).
valorCasa(nico, 80000).
valorCasa(alf, 75000).
valorCasa(julian, 140000).
valorCasa(vale, 95000).
valorCasa(fer, 60000).

cantidadCasasQuePodemosComprar(Presupuesto, Cantidad):-
    findall(Valor, valorCasa(_, Valor), ListaValores),
    contarComprables(ListaValores, Presupuesto, Cantidad).

contarComprables([Valor|Cola], Presupuesto, Cantidad):-
    Presupuesto >= Valor,
    NuevoPresupuesto is Presupuesto - Valor,
    contarComprables(Cola, NuevoPresupuesto, CantidadRestante),
    Cantidad is CantidadRestante + 1.

contarComprables([Valor|Cola], Presupuesto, Cantidad):-
    Presupuesto < Valor,
    contarComprables(Cola, Presupuesto, Cantidad).


casasComprables(Presupuesto, Combinacion, Cantidad):-
    findall(Valor, valorCasa(_, Valor), TodosLosValores),
    sublista(TodosLosValores, Combinacion),
    sum_list(Combinacion, CostoTotal),
    CostoTotal =< Presupuesto,
    length(Combinacion, Cantidad).


% Tu predicado principal
cantidadCasasComprables(Presupuesto, Cantidad):-
    findall(Valor, valorCasa(_, Valor), ListaTotal),
    subconjunto(ListaTotal, Combinacion),
    sum_list(Combinacion, CostoTotal),
    CostoTotal =< Presupuesto,
    length(Combinacion, Cantidad).