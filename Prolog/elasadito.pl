% define quiénes son amigos de nuestro cliente
amigo(mati). amigo(pablo). amigo(leo).
amigo(fer). amigo(flor).
amigo(ezequiel). amigo(marina).
% define quiénes no se pueden ver
noSeBanca(leo, flor). noSeBanca(pablo, fer).
noSeBanca(fer, leo). noSeBanca(flor, fer).
% define cuáles son las comidas y cómo se componen
% functor achura contiene nombre, cantidad de calorías
% functor ensalada contiene nombre, lista de ingredientes
% functor morfi contiene nombre (el morfi es una comida principal)
comida(achura(chori, 200)). % ya sabemos que el chori no es achura
comida(achura(chinchu, 150)).
comida(ensalada(waldorf, [manzana, apio, nuez, mayo])).
comida(ensalada(mixta, [lechuga, tomate, cebolla])).
comida(morfi(vacio)).
comida(morfi(mondiola)).
comida(morfi(asado)).
% relacionamos la comida que se sirvió en cada asado
% cada asado se realizó en una única fecha posible: functor fecha + comida
asado(fecha(22,9,2011), chori). asado(fecha(15,9,2011), mixta).
asado(fecha(22,9,2011), waldorf). asado(fecha(15,9,2011), mondiola).
asado(fecha(22,9,2011), vacio). asado(fecha(15,9,2011), chinchu).
% relacionamos quiénes asistieron a ese asado
asistio(fecha(15,9,2011), flor). asistio(fecha(22,9,2011), marina).
asistio(fecha(15,9,2011), pablo). asistio(fecha(22,9,2011), pablo).
asistio(fecha(15,9,2011), leo). asistio(fecha(22,9,2011), flor).
asistio(fecha(15,9,2011), fer). asistio(fecha(22,9,2011), mati).
% definimos qué le gusta a cada persona
leGusta(mati, chori). leGusta(fer, mondiola). leGusta(pablo, asado).
leGusta(mati, vacio). leGusta(fer, vacio).
leGusta(mati, waldorf). leGusta(flor, mixta).

leGusta(ezequiel, Cosa) :-
    leGusta(mati, Cosa).

leGusta(ezequiel, Cosa) :-
    leGusta(fer, Cosa).

leGusta(marina, Cosa) :-
    leGusta(flor, Cosa).

leGusta(marina, mondiola).

leGusta(leo, Cosa) :-
    leGusta(leo, Cosa),
    Cosa \= waldorf.

asadoViolento(FechaAsado):-
    asado(FechaAsado,_),
    forall(asistio(FechaAsado,Persona1),(asistio(FechaAsado,Persona2),Persona1\=Persona2, noSeBanca(Persona1,Persona2))).


calorias(Comida, 200):-
    comida(morfi(Comida)).

calorias(Comida,Calorias):-
    comida(ensalada(Comida,ListaIngredientes)),
    length(ListaIngredientes,Calorias).

calorias(Comida,Calorias):-
    comida(achura(Comida,Calorias)).

asadosFlojito(FechaAsado):-
    findall(Calorias, (asado(FechaAsado,Comida), calorias(Comida,Calorias)), ListaCalorias),
    sum_list(ListaCalorias, TotalCalorias),
    TotalCalorias < 400.

hablo(fecha(15,09,2011), flor, pablo). hablo(fecha(22,09,2011), flor, marina).
hablo(fecha(15,09,2011), pablo, leo). hablo(fecha(22,09,2011), marina, pablo).
hablo(fecha(15,09,2011), leo, fer). reservado(marina).

chismeDe(FechaAsado,Persona,OtraPersona):-
    hablo(FechaAsado,OtraPersona,Persona).

chismeDe(FechaAsado, Persona, OtraPersona) :-
    hablo(FechaAsado, Alguien, Persona),
    not(reservado(Alguien)),
    chismeDe(FechaAsado,OtraPersona, Alguien).


disfruto(Persona, FechaAsado):-
    asistio(FechaAsado,Persona),
    findall(Comida, asado(FechaAsado, Comida), leGusta(Persona,Comida), ListaComidas),
    length(ListaComidas,Cant),
    Cant >=3.

asadoRico(Comidas):-
    



    




