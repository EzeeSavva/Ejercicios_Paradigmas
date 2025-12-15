% 1. Predicado vive(Persona, TipoVivienda, Detalle1, Detalle2, Barrio).
%    Detalles: metros (para casa/loft), ambientes (para ambientes).
%    Detalle2: anio (para loft), banos (para ambientes).

vive(juan, casa, 120, _, almagro).          % Juan: casa, 120m2
vive(nico, ambiente, 3, 2, almagro).        % Nico: 3 ambientes, 2 baños
vive(alf, ambiente, 2, 1, almagro).         % Alf: 2 ambientes, 1 baño
vive(julian, loft, 2000, _, almagro).       % Julian: loft, construido en el 2000
vive(vale, ambiente, 4, 1, flores).         % Vale: 4 ambientes, 1 baño
vive(fer, casa, 110, _, flores).            % Fer: casa, 110m2

% 2. Predicado ubicacion_desconocida(Persona).
ubicacion_desconocida(felipe).              % No sabemos dónde vive Felipe

% 3. Predicado quiere_mudar(Persona, TipoVivienda, Metros).
quiere_mudar(rocio, casa, 90).              % Rocio se quiere mudar a una casa de 90m2


tasacion(juan, 150000).
tasacion(nico, 80000).
tasacion(alf, 75000).
tasacion(julian, 140000).
tasacion(vale, 95000).
tasacion(fer, 60000).


esPersonaCopada(Persona):-
    vive(Persona,casa,CantidadMetros,_,_),
    CantidadMetros > 100.

esPersonaCopada(Persona):-
    vive(Persona, ambiente, CantidadAmbientes, CantidadBanios, _),
    CantidadBanios > 1 ; 
    CantidadAmbientes > 3.

esPersonaCopada(Persona):-
    vive(Persona, loft, Anio, _, _),
    Anio > 2015.

%esPropiedadCopada(Persona):-       findall(Persona, esPersonaCopada(Persona), ListaPersonas)%

barrioCopado(Barrio):-
    vive(Persona, _,_,_,Barrio),
    esPersonaCopada(Persona).

barrioCaro(Barrio):-
    vive(_,_,_,_,Barrio),
    not tieneCasaBarata(Barrio).

tieneCasaBarata(Barrio):-
    vive(_,casa, Metros, _, Barrio),
    Metros < 90.

tieneCasaBarata(Barrio):-
    vive(_, loft, Anio, _, Barrio),
    Anio < 2005.

tieneCasaBarata(Barrio):-
    vive(_,ambiente, CantidadAmbientes, _, Barrio),
    between(1, 2, CantidadAmbientes).
    

comprarPropiedad(PlataTotal, PlataRestante):-
    vive(Persona, _,_,_,_),
    tasacion(Persona, PrecioCasa),
    findall(Casas, sePuedeComprar(PlataTotal, PlataRestante), ListaCasas).



sePuedeComprar(PlataTotal, PlataRestante):-
    tasacion(_, PrecioCasa),
    PlataTotal < PrecioCasa,
    PlataRestante is PlataTotal - PrecioCasa.






    