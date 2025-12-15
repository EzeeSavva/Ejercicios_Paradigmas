%El amor está en el aire
%Se acerca la primaveral Florecen el amor y las alergias. Un grupo de gente que no conoce lo que es sentir afecto nos pidió modelar un sistema en Prolog para matchear personas y ayudarlas
%a découvrir l'amour. Este sistema funciona distinto a las aplicaciones de citas tradicionales: en lugar de ser las personas quienes eligen o rechazan a sus posibles candidatos, nuestro algoritmo
%determina los matches en función de sus preferencias. Veamos los detalles.

%Registro
%Cada persona se registra en nuestro sistema con un nombre, una edad, y un género con el que se identifica. Luego se le pide algunos datos para identificar quiénes podrian ser sus pretendientes.
%En particular, debe especificar qué género o géneros le interesan, una edad minima y máxima para sus parejas, y una cantidad ilimitada de cosas que le gustan y le disgustan. Una persona tiene su perfil
%incompleto si no proveyó alguno de estos datos, incluyendo gustos y disgustos, de los cuales deben completar con al menos cinco de cada uno. También se considera incompleto si su edad es menor a 18,
%ya que sólo admitimos mayores de edad.

%Análisis
%Sabiendo los perfiles de las personas, nuestros sistemas de análisis de datos empiezan a trabajar. Alguien es un alma libre si siente interés romántico por todos los géneros con los que se identifican
%los usuarios que están en nuestra base de conocimiento, o si acepta pretendientes en un rango más amplio que 30 años (por ejemplo: de 21 a 55, o de 40 a 72); mientras que quiere la herencia si la
%edad mínima que pretende para sus parejas es al menos 30 años más alta que su edad. También puede ocurrir que sea indeseable si no hay nadie que sea pretendiente de esa persona.

%Matches
%Con todos los perfiles en su lugar, es momento de matchear a las personas. Una persona es pretendiente de otra cuando el género y edad de la otra coinciden con los intereses de la primera, además de
%que ambas tienen al menos un gusto en común. Si dos personas son pretendientes entre sí, decimos que hay match. Esto genera algunas figuras geométricas interesantes: por ejemplo, tenemos un triángulo amoroso 
%cuando una persona es pretendiente de otra, la cual es pretendiente de una tercera, la cual es pretendiente de la primera, pero sin matches entre ninguna de ellas. En otros casos, dos personas son el uno
%para el otro, porque además de haber match, no hay ningún gusto de una que le disguste a la otra.

%Mensajes
%Las personas pueden enviarse mensajes en el chat interno de nuestro sistema. Por una cuestión de privacidad, no podemos ver el contenido de los mensajes, pero sí tenemos el predicado indiceDeAmor/3,
%que relaciona a una persona que le envia un mensaje a otra con el indice de amor que tenía ese mensaje, el cual puede ir de 0 (en un mensaje como "hola") a 10 (en un mensaje como "Te amo 09900").
%Por cada mensaje enviado se agrega una nueva cláusula de indiceDeAmor/3. Cuando para los mensajes entre dos personas ocurre que el indice de amor promedio de los mensajes enviados por una es más del
%doble respecto al indice de amor promedio de los mensajes enviados por la otra, decimos que hay un desbalance entre esas dos personas. Por último, una persona ghostea a la otra si recibió mensajes de
%ella pero jamás le respondió
%1. Diseñar la base de conocimiento y proveer ejemplos.
%2. Cumplir, mediante predicados completamente inversibles, con todos los requerimientos enunciados
%Realizar soluciones declarativas, que no repitan lógica y que cumplan con los fundamentos del paradigma



% Personas
persona(ana, 25, femenino).
persona(juan, 28, masculino).
persona(lucas, 22, masculino).
persona(maria, 30, femenino).
persona(carla, 27, femenino).
persona(martin, 24, masculino).

% Géneros que le gustan (más de uno)
generosQueLeGustan(ana, [masculino, no_binario]).
generosQueLeGustan(juan, [femenino, no_binario, masculino]).
generosQueLeGustan(lucas, [femenino, femenino]).
generosQueLeGustan(maria, [masculino, no_binario]).
generosQueLeGustan(carla, [masculino, femenino]).
generosQueLeGustan(martin, [femenino, no_binario]).

% Edad mínima y máxima de interés
edMin(ana, 24).
edadMax(ana, 30).

edMin(juan, 22).
edadMax(juan, 32).

edMin(lucas, 20).
edadMax(lucas, 26).

edMin(maria, 25).
edadMax(maria, 35).

edMin(carla, 23).
edadMax(carla, 29).

edMin(martin, 21).
edadMax(martin, 28).

% Gustos (más de 5)
gustos(ana, [cine, musica, viajar, lectura, deportes, cocina]).
gustos(juan, [deporte, leer, musica, tecnologia, videojuegos, viajar]).
gustos(lucas, [videojuegos, cine, futbol, musica, comida, viajes]).
gustos(maria, [musica, arte, leer, danza, cine, viajar]).
gustos(carla, [viajar, cine, musica, fotografia, arte, lectura]).
gustos(martin, [deporte, cine, leer, tecnologia, musica, cocina]).

% Disgustos (más de 5)
disgustos(ana, [fumar, ruidoso, desorden, impuntualidad, mentir, arrogancia]).
disgustos(juan, [desorden, mentir, impuntualidad, groseria, fumar, ruidoso]).
disgustos(lucas, [ruidoso, fumar, desorden, mentir, arrogancia, hipocresia]).
disgustos(maria, [mentir, desorden, arrogancia, ruidoso, egoismo, impuntualidad]).
disgustos(carla, [fumar, aburrido, ruidoso, arrogancia, desorden, impuntualidad]).
disgustos(martin, [mentir, desorden, egoismo, fumar, ruidoso, groseria]).


perfilIncompleto(Persona):-
    not(perfilCompleto(Persona)).


perfilCompleto(Persona):-
    persona(Persona,Edad,_),
    Edad > 18,
    generosQueLeGustan(Persona, _),
    edadMax(Persona, _),
    edMin(Persona, _),
    gustos(Persona, ListaGustos),
    disgustos(Persona, ListaDisgustos),
    cantidadAmbos(ListaGustos),
    cantidadAmbos(ListaDisgustos).

cantidadAmbos(Lista):-
length(Lista, Cantidad),
Cantidad > 5.


almaLibre(Persona):-
    persona(Persona,_,_),
    generosQueLeGustan(Persona,generos(si, si)).

almaLibre(Persona):-
    persona(Persona, _, _),
    edadMax(Persona, EdadMax),
    edMin(Persona,edMin),
    EdadTotal is (EdadMax - edMin),
    EdadTotal > 30.


quiereLaHerencia(Persona):-
    persona(Persona,Edad,_),
    edMin(Persona, edMin),
    DiferenciaEdad is (edMin - Edad),
    DiferenciaEdad > 30.

esIndeseable(Persona):-
    not(matchea(Persona,_)).

pretendiente(Persona, OtraPersona):-  
    persona(Persona,_,_),
    persona(OtraPersona,_,_),
    matcheaEdad(Persona,OtraPersona),
    matcheaGenero(Persona,OtraPersona),
    gustoEnComun(Persona,OtraPersona).

matcheaGenero(Persona,OtraPersona):-
    persona(Persona,_,_),
    persona(OtraPersona, _,GeneroOtraPersona),
    generosQueLeGustan(Persona, ListaGenero),
    member(GeneroOtraPersona, ListaGenero).


matcheaEdad(Persona,OtraPersona):-
    persona(Persona,_,_),
    persona(OtraPersona,EdadOtraPersona,_),
    edMin(Persona,edMin),
    edadMax(Persona,EdadMax),
    between(EdadOtraPersona, edMin,EdadMax).

gustoEnComun(Persona, OtraPersona):-
    gustos(Persona, ListaGustos),
    gustos(OtraPersona, ListaGustosOtraPersona),
    findall(Gusto, (member(Gusto,ListaGustosOtraPersona),member(Gusto,ListaGustos)), ListaDeGustosEnComun),
    length(ListaDeGustosEnComun, CantidadGustosEnComun),
    CantidadGustosEnComun >= 1.


matchea(Persona,Pretendiente):-
    Persona \= Pretendiente,
    pretendiente(Persona,Pretendiente),
    pretendiente(Pretendiente,Persona).



%Esto genera algunas figuras geométricas interesantes: por ejemplo, tenemos un triángulo amoroso 
%cuando una persona es pretendiente de otra, la cual es pretendiente de una tercera, la cual es pretendiente de la primera, pero sin matches entre ninguna de ellas. En otros casos, dos personas son el uno
%para el otro, porque además de haber match, no hay ningún gusto de una que le disguste a la otra.

trianguloAmoroso(Primero,Segundo,Tercero):-
    pretendiente(Primero,Segundo),
    pretendiente(Segundo,Tercero),
    pretendiente(Tercero,Primero),
    not(matchea(Primero,Tercero)),
    not(matchea(Segundo,Primero)),
    not(matchea(Segundo,Tercero)).


sonElUnoParaElOtro(Primero,Segundo):-
    matchea(Primero,Segundo),
    gustos(Primero, ListaGustos),
    disgustos(Primero, ListaDisgustos),
    gustos(Segundo, ListaGustosSegundo),
    disgustos(Segundo, ListaDisgustosSegundo),
    forall(member(GustoPrimero,ListaGustos), not(member(GustoPrimero, ListaDisgustosSegundo))),
    forall(member(GustoSegundo,ListaDisgustosSegundo), not(member(GustoSegundo, ListaDisgustosPrimero))).


%Mensajes
%Las personas pueden enviarse mensajes en el chat interno de nuestro sistema. Por una cuestión de privacidad, no podemos ver el contenido de los mensajes, pero sí tenemos el predicado indiceDeAmor/3,
%que relaciona a una< persona que le envia un mensaje a otra con el indice de amor que tenía ese mensaje, el cual puede ir de 0 (en un mensaje como "hola") a 10 (en un mensaje como "Te amo <3<3<3").
%Por cada mensaje enviado se agrega una nueva cláusula de indiceDeAmor/3. Cuando para los mensajes entre dos personas ocurre que el indice de amor promedio de los mensajes enviados por una es más del
%doble respecto al indice de amor promedio de los mensajes enviados por la otra, decimos que hay un desbalance entre esas dos personas. Por último, una persona ghostea a la otra si recibió mensajes de
%ella pero jamás le respondió
%1. Diseñar la base de conocimiento y proveer ejemplos.
%2. Cumplir, mediante predicados completamente inversibles, con todos los requerimientos enunciados
%Realizar soluciones declarativas, que no repitan lógica y que cumplan con los fundamentos del paradigma

indiceDeAmor(ana, juan, 5).
indiceDeAmor(ana, juan, 8).
indiceDeAmor(juan, ana, 2).
indiceDeAmor(maria, ana, 10).


desbalance(Persona,OtraPersona):-
    promedioIndiceAmorPersona(Persona,OtraPersona,PromedioPersona),
    promedioIndiceAmorPersona(OtraPersona,Persona,PromedioOtraPersona),
    PromedioOtraPersona is 2*PromedioPersona.

promedioIndiceAmor(Persona,OtraPersona,PromedioPersona):-
    aggregate_all((sum(Indice),count(Indice)), indiceDeAmor(Persona,OtraPersona), (Suma,Cantidad)),
    PromedioPersona is (Suma / Cantidad).

ghostea(Persona,OtraPersona):-
    indiceDeAmor(Persona,OtraPersona,_),
    not(indiceDeAmor(OtraPersona,Persona,_)).



    





































