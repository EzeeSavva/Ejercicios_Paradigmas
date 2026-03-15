%comio(Personaje, Bicho)
comio(pumba, vaquitaSanAntonio(gervasia,3)).
comio(pumba, hormiga(federica)).
comio(pumba, hormiga(tuNoEresLaReina)).
comio(pumba, cucaracha(ginger,15,6)).
comio(pumba, cucaracha(erikElRojo,25,70)).
comio(timon, vaquitaSanAntonio(romualda,4)).
comio(timon, cucaracha(gimeno,12,8)).
comio(timon, cucaracha(cucurucha,12,5)).
comio(simba, vaquitaSanAntonio(remeditos,4)).
comio(simba, hormiga(schwartzenegger)).
comio(simba, hormiga(niato)).
comio(simba, hormiga(lula)).
pesoHormiga(2).
%peso(Personaje, Peso)
peso(pumba, 100).
peso(timon, 50).
peso(simba, 200).


%%Punto 1

esJugosita(cucaracha(Nombre,Tamanio,Peso)):-
    comio(_, cucaracha(Nombre, Tamanio, Peso)),
    comio(cucaracha(OtroNombre, Tamanio, OtroPeso)),
    Nombre \= OtroNombre,
    OtroPeso > Peso.


esHormigofilico(Personaje):-
    comio(Personaje, _),
    contarHormigasQueComio(Personaje, Cantidad),
    Cantidad >= 2.


contarHormigasQueComio(Personaje,Cantidad):-
    findall(Hormiga, comio(Personaje, hormiga(Hormiga)), ListaHormigas),
    length(ListaHormigas, Cantidad).

esCucarachofobico(Personaje):-
    peso(Personaje, _),
    not(comio(Personaje, cucaracha(_,_,_))).

esPicaron(Personaje):-
    peso(Personaje, _),
    seComioAlgoEspecifico(Personaje).

seComioAlgoEspecifico(Personaje):-
    comio(Personaje, vaquitaSanAntonio(remeditos,_)).

seComioAlgoEspecifico(Personaje):-
    comio(Personaje, Cucaracha),
    esJugosita(Cucaracha).
    
picarones(ListaPicarones):-
    findall(Personaje, esPicaron(Personaje), ListaPicarones).

persigue(scar, timon).
persigue(scar, pumba).
persigue(shenzi, simba).
persigue(shenzi, scar).
persigue(banzai, timon).

comio(shenzi,hormiga(conCaraDeSimba)).

peso(scar, 300).
peso(shenzi, 400).
peso(banzai, 500).

cuantoEngorda(Personaje, PesoTotal):-
    peso(Personaje, Peso),
    findall(PesoBicho, (comio(Personaje, Bicho), pesoDelBicho(Bicho, PesoBicho)), ListaPeso),
    sumlist(ListaPeso, PesoTotalLista),
    PesoTotal is PesoTotalLista + Peso.

pesoDelBicho(vaquitaSanAntonio(_,Peso), Peso).
pesoDelBicho(cucaracha(_,_,Peso), Peso).
pesoDelBicho(hormiga(_), Peso):-
    pesoHormiga(Peso).
pesoDelBicho(Personaje, Peso):-
    peso(Personaje, Peso).

cuantoEngorda(Personaje, PesoTotal):-
    persigue(Personaje, _),
    findall(OtroPeso, (persigue(Personaje, OtroPersonaje),pesoDelBicho(OtroPersonaje, OtroPeso)), ListaPesos),
    sumlist(ListaPesos, PesoTotal).

cuantoEngorda(Personaje, PesoTotal):-
    persigue(Personaje, _),
    findall(PesoPresa, (persigue(Personaje, Presa), pesoDelBicho(Presa, PesoPresa)), ListaPresas),
    sumlist(ListaPresas, TotalPresas),
    findall(PesoBicho, (persigue(Personaje, Presa), comio(Presa, Bicho), pesoDelBicho(Bicho, PesoBicho)), ListaBichos),
    sumlist(ListaBichos, TotalBichos),
    PesoTotal is TotalPresas + TotalBichos.

persigue(scar, mufasa).

adora(Personaje):-
    peso(Personaje,_),
    loAdoran(Personaje).

loAdoran(Personaje):-
    not(comio(Personaje_,_)).

loAdoran(Personaje):-
    not(persigue(Personaje,_)).

esRey(Personaje):-
    peso(Personaje, _),
    todosLoAdoran(Personaje),
    loPersigueUnoSolo(Personaje).

todosLoAdoran(Personaje):-
    forall(persigue(OtroPersonaje, Personaje), adora(OtroPersonaje)).

loPersigueUnoSolo(Personaje):-
    peso(OtroPersonaje, _),
    findall(OtroPersonaje, persigue(OtroPersonaje, Personaje), ListaPersonajes),
    length(ListaPersonajes, 1).









