% jugadores conocidos
jugador(maradona).
jugador(chamot).
jugador(balbo).

jugador(caniggia).
jugador(passarella).
jugador(pedemonti).
jugador(basualdo).

% relaciona lo que toma cada jugador
tomo(maradona, sustancia(efedrina)).
tomo(maradona, compuesto(cafeVeloz)).
tomo(caniggia, producto(cocacola, 2)).
tomo(chamot, compuesto(cafeVeloz)).
tomo(balbo, producto(gatoreit, 2)).
% relaciona la máxima cantidad de un producto que 1 jugador puede ingerir
maximo(cocacola, 3). maximo(gatoreit, 1).
maximo(naranju, 5).

% relaciona las sustancias que tiene un compuesto
composicion(cafeVeloz, [efedrina, ajipupa, extasis, whisky, cafe]).
% sustancias prohibidas por la asociación
sustanciaProhibida(efedrina). sustanciaProhibida(cocaina).


tomaLoMismo(pasarella,Bebida):-
not(tomo(maradona,Bebida)).

tomaLoMismo(pedemonti,Bebida):-
tomo(chamot,Bebida).

tomaLoMismo(pedemonti,Bebida):-
tomo(maradona,Bebida).

noTomaCocaCola(basualdo,cocacola):-
not(tomo(basualdo,producto(cocacola,_))).

puedeSerSuspendido(Jugador):-
sustanciaProhibida(Sustancia),
tomo(Jugador,sustancia(Sustancia)).

puedeSerSuspendido(Jugador):-
tomo(Jugador,compuesto(Composicion)),
composicion(Composicion, ListaSustancias),
member(Sustancia,ListaSustancias),
sustanciaProhibida(Sustancia).

puedeSerSuspendido(Jugador):-
    tomo(Jugador,producto(Bebida,CantidadTomada)),
    maximo(Bebida, NumMaximo),
    CantidadTomada >= NumMaximo.


amigo(maradona, caniggia).
amigo(caniggia, balbo).

amigo(balbo, chamot).
amigo(balbo, pedemonti).


malaInfluencia(Jugador1,Jugador2):-
    seConocen(Jugador1, Jugador2),
    Jugador1 \= Jugador2,
    puedeSerSuspendido(Jugador1),
    puedeSerSuspendido(Jugador2).

seConocen(Jugador1, Jugador2) :-
    amigo(Jugador1, Jugador2).

seConocen(Jugador1, Jugador2) :-
    amigo(Jugador1, JugadorIntermedio),
    seConocen(JugadorIntermedio, Jugador2).


atiende(cahe, maradona).
atiende(cahe, chamot).
atiende(cahe, balbo).

atiende(zin, caniggia).
atiende(cureta, pedemonti).
atiende(cureta, basualdo).

chanta(Medico):-
    atiende(Medico,_),
    forall(atiende(Medico,Jugador), puedeSerSuspendido(Jugador)).

nivelFalopez(efedrina, 10).
nivelFalopez(cocaina, 100).

nivelFalopez(extasis, 120).
nivelFalopez(omeprazol, 5).

cuantaFalopaTiene(Jugador,0):-
    jugador(Jugador),
    tomo(Jugador,producto(cocacola,_)).

cuantaFalopaTiene(Jugador,0):-
    jugador(Jugador),
    tomo(Jugador,producto(gatoreit,_)).

cuantaFalopaTiene(Jugador, NivelFalopez):-
    jugador(Jugador),
    findall(Nivel, nivelDeLoQueToman(Jugador,Nivel), ListaNiveles),
    sum_list(ListaNiveles, NivelFalopez).

nivelDeLoQueToman(Jugador,NivelFalopez):-
    tomo(Jugador,sustancia(Sustancia)),
    nivelFalopez(Sustancia,NivelFalopez).

nivelDeLoQueToman(Jugador,NivelFalopez):-
    tomo(Jugador,compuesto(Composicion)),
    composicion(Composicion, ListaSustancias),
    member(Sustancia,ListaSustancias),
    nivelFalopez(Sustancia, NivelFalopez).

medicoConProblemas(Medico):-
    jugador(Jugador),
    atiende(Medico, Jugador),
    puedeSerSuspendido(Jugador).

medicoConProblemas(Medico):-
    jugador(Jugador),
    atiende(Medico, Jugador),
    seConocen(maradona,Jugador).

programaTVFantinesco(ListaJugadores):-
    setof(Jugador, puedeSerSuspendido(Jugador), ListaJugadores).
    

    


