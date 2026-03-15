persona(dibu,parrillero).
usa(dibu, parrilla).
persona(messi, comensal).
leGusta(messi, asado).
persona(dePaul, comensal).
leGusta(dePaul,asado).
persona(kun, comensal).
leGusta(kun, chori).
persona(papu, vegetariano).
trae(papu, ensalada).
esContudente(ensalada).
persona(scaloni, parrillero).
usa(scaloni, cruz).
esPaciente(scaloni).
persona(icardi,comensal).

asiste(sabado, dibu).
asiste(sabado, scaloni).
asiste(sabado, messi).
asiste(sabado, papu).

asiste(domingo, scaloni).
asiste(domingo, messi).
asiste(domingo, dePaul).
asiste(domingo, papu).


%%Punto 2

laEstaPasandoBien(Persona):-
    persona(Persona, Tipo),
    satisfaceTipo(Persona,Tipo).

satisfaceTipo(Persona, parrillero):-
    usa(Persona, cruz),
    esPaciente(Persona).

satisfaceTipo(Persona,comensal):-
    leGusta(Persona, asado).

satisfaceTipo(Persona, comensal):-
    not(haceDieta(Persona)).

satisfaceTipo(Persona, vegetariano):-
    trae(Persona, Comida),
    esContudente(Comida).

todosLaPasanBien(Dia):-
    asiste(Dia,_),
    forall(asiste(Dia,Persona), laEstaPasandoBien(Persona)).
    

%%Punto 3

esFalluto(Persona):-
    asiste(_,Persona),
    not(tieneAsistenciaPerfecta(Persona)).

tieneAsistenciaPerfecta(Persona):-
    asiste(sabado,Persona),
    asiste(domingo,Persona).

%% Punto 4

totalAportado(Persona, Total):-
    asiste(Dia, Persona),
    findall(Dinero, (asiste(Dia, Persona), poneDinero(Persona, Dinero)), ListaDeDinero),
    sumlist(ListaDeDinero, Total).  /* Esto me dice el total de una persona en un dia especifico */

asistenteQueMasAporta(Dia):-
    asiste(Dia,Persona), 
    totalAportado(Persona, MontoMax),
    forall((asiste(Dia,OtraPersona), totalAportado(OtraPersona, OtroMonto)) , MontoMax >= OtroMonto).
    
poneDinero(Persona,0):-
    persona(Persona, parrillero).

poneDinero(Persona,1000):-
    leGusta(Persona,asado).

poneDinero(Persona, 800):-
    leGusta(Persona, chori),
    haceDieta(Persona).

poneDinero(Persona, 700):-
    leGusta(Persona, chori),
    not(haceDieta(Persona)).

poneDinero(Persona, 500):-
    persona(Persona, vegetariano).


