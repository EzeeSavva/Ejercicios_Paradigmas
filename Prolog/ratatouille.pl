%rata(nombre, dondeviven).

rata(remy, gusteaus).
rata(emile, chezMilleBar).
rata(django, pizzeriaJeSuis).

humano(amelie).
/*cocina(nombre, nombrePlato, experiencia).*/

cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(skinner, ratatouille, 8).


trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, horst).
trabajaEn(gusteaus, skinner).

trabajaEn(cafedes2moulins, amelie).

estaEnElMenu(Plato, Restaurant):-
    trabajaEn(Restaurante, Persona),
    cocina(Persona,Plato, _).

cocinaBien(Persona, Plato):-
    cocina(Persona, Plato, Experiencia),
    Experiencia > 7.

cocinaBien(Persona, Plato):-
    cocina(Persona, Plato, _),
    tieneTutor(Persona, _).

tieneTutor(Persona, Rata):-
    trabajaEn(Restaurant, Persona),
    rata(Rata, Restaurant).

tieneTutor(skinner, amelie).

cocinaBien(remy,Plato):-
    estaEnElMenu(Plato, _).

%% punto 3

esChef(Persona, Restaurant):-
    trabajaEn(Restaurant, Persona),
    cocinaBienTodosLosPlatos(Persona, Restaurant).

esChef(Persona,Restaurant):-
    trabajaEn(Restaurant, Persona),
    sumaExperiencia(Persona,Restaurant, ExperienciaTotal) 
    ExperienciaTotal > 20.

cocinaBienTodosLosPlatos(Persona, Restaurant):-
    estaEnElMenu(_,Restaurant),
    forall(estaEnElMenu(Plato,Restaurant), cocinaBien(Persona, Plato)).

sumaExperiencia(Persona, Restaurant, ExperienciaTotal):-
    trabajaEn(_,Persona),
    findall(Experiencia, cocina(Persona,Plato,Experiencia), ListaExperiencia),
    sumlist(ListaExperiencia, ExperienciaTotal).

%% Punto 4

esElEncargado(Persona, Plato, Restaurant):-
    trabajaEn(Restaurant, Persona),
    cocina(Persona, Plato, MiExperiencia),
    forall(personaQuePuedeSerEncargada(Persona, Plato, Restaurant, ExperienciaOtraPersona), MiExperiencia > ExperienciaOtraPersona).

personaQuePuedeSerEncargada(Persona, Plato, Restaurant, ExperienciaOtraPersona):-
    trabajaEn(Restaurant, OtraPersona),
    Persona \= OtraPersona,
    cocina(OtraPersona, Plato, ExperienciaOtraPersona).

%% Punto 5

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 20)).
plato(frutillasConCrema, postre(265)).

esSaludable(Plato):-
    calorias(Plato, Cantidad),
    Cantidad < 75.

calorias(Plato, Cantidad):-
    plato(Plato, entrada(Ingredientes)),
    length(Ingredientes, Numero),
    Cantidad is Numero * 15.

calorias(Plato, Cantidad):-
    plato(Plato, principal(Ingrediente, Minutos)),
    sumarGuarnicion(Ingrediente, PrecioGuarnicion),
    Calorias is 5 * Minutos + PrecioGuarnicion.

sumarGuarnicion(papasfritas, 50).
sumarGuarnicion(pure, 20).
sumarGuarnicion(ensalada, 0).

calorias(Plato, Calorias):-
    plato(Plato, postre(Calorias)).

%% Punto 6

darResenia(Persona, Restaurant):-
    trabajaEn(Restaurant, _),
    reseniaPositiva(Persona, Restaurant).

esEspecialista(Restaurant, Plato):-
    estaEnElMenu(Plato, Restaurant),
    forall(esChef(Persona, Restaurant), cocinaBien(Persona, Plato)).

reseniaPositiva(antonEgo, Restaurant) :-,           
    not(rata(_, Restaurant)),           
    esEspecialista(Restaurant, ratatouille).

reseniaPositiva(cormillot, Restaurant):-
    forall((trabajaEn(Restaurant, Persona),cocina(Persona, Plato, _)), esSaludable(Plato)).

reseniaPositiva(martiniano, Restaurant):-
    findall(Chef, esChef(Persona, Restaurant), ListaChef),
    length(ListaChef, 1).

/*Gordon ramsey no tiene reseñas positivas, por lo cual no se hace nada, por principio de universo cerrado, no le escribimos una clausula para el */



    

    