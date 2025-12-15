trabajaEn(ventas, kyle).
trabajaEn(ventas, trisha).
trabajaEn(ventas, joshua).

trabajaEn(logistica, sherri).
trabajaEn(logistica, ian).

trabajaEn(arquitectura, joshua).


% promedio(Horas, PromedioSueldo)
promedio(6, 45).
promedio(7, 60).
promedio(8, 80).

persona(kyle, asalariado,50).
persona(sherri, asalariado,60).
persona(gus, asalariado, 60).

persona(ian, jefe,40).
persona(trisha, jefe,90).
persona(joshua, independiente, 55).

asalariado(kyle,6).
asalariado(sherri,7).
asalariado(gus,8).

esJefeDe(kyle, ian).
esJefeDe(rob, ian).
esJefeDe(ginger,ian).
esJefeDe(ian, trisha).
esJefeDe(gus,trisha).


esPaganini(Departamento):-
    trabajaEn(Departamento, Persona),
    forall(trabajaEn(Departamento,_),ganaBien(Persona)).

ganaBien(Persona):-
    persona(Persona, asalariado, Pago),
    asalariado(Persona, Horas),
    promedio(Horas, Promedio),
    Pago >  Promedio.

ganaBien(Persona):-
    persona(Persona, jefe, Pago),
    findall(_,esJefeDe(Subordinado,Persona), ListaPersonasACargo),
    length(ListaPersonasACargo, CantidadPersonasACargo),
    Limite is 20* CantidadPersonasACargo,
    Pago > Limite.

ganaBien(Persona):-
    persona(Persona,independiente, _),
    trabajaEn(arquitectura,Persona).

ganaBien(Persona):-
    persona(Persona,independiente,Pago),
    Pago > 70.

%3.

leGustaTrabajarEn(ventas, kyle).
leGustaTrabajarEn(logistica,kyle).
leGustaTrabajarEn(ventas, trisha).
leGustaTrabajarEn(ventas, joshua).
leGustaTrabajarEn(contabilidad,sherri).
leGustaTrabajarEn(facturacion, sherri).
leGustaTrabajarEn(cobranzas, sherri).

estaEnProblemas(Departamento):-
    trabajaEn(Departamento, _),
    forall(trabajaEn(Departamento,Persona), not(leGustaTrabajarEn(Departamento, Persona))).

%4.

% 1. CASO BASE: Generar un subconjunto de una lista vacía es una lista vacía.
subconjunto([], []).

% 2. CASO RECURSIVO 1: INCLUIR la Cabeza en el subconjunto.
subconjunto([Cabeza | Cola], [Cabeza | SubconjuntoCola]) :-
    subconjunto(Cola, SubconjuntoCola).

% 3. CASO RECURSIVO 2: EXCLUIR la Cabeza del subconjunto.
subconjunto([ _ | Cola], SubconjuntoCola) :-
    subconjunto(Cola, SubconjuntoCola).

% suma_sueldos(Equipo, SueldoTotal)
suma_sueldos([], 0).

suma_sueldos([Persona | Cola], SueldoTotal) :-
    % 1. Obtener lo que gana la Persona
    persona(Persona, _, SueldoIndividual), 
    % 2. Sumar el resto
    suma_sueldos(Cola, SueldoRestante),
    % 3. Calcular el total
    SueldoTotal is SueldoIndividual + SueldoRestante.

todas_las_personas(ListaCompleta) :-
    findall(P, persona(P, _, _), ListaCompleta).

reorganizar(Presupuesto, Equipo, Sobrante) :-
    % 1. Generar un subconjunto (Equipo) de todas las personas
    todas_las_personas(ListaCompleta),
    subconjunto(ListaCompleta, Equipo),
    
    % 2. Restricción 1: El equipo debe tener al menos 2 personas
    length(Equipo, Cantidad),
    Cantidad >= 2,
    
    % 3. Cálculo: Sumar los sueldos de los miembros del equipo
    suma_sueldos(Equipo, CostoTotal),
    
    % 4. Restricción 2: El costo no debe exceder el presupuesto
    CostoTotal =< Presupuesto,
    
    % 5. BONUS: Calcular lo que sobra
    Sobrante is Presupuesto - CostoTotal.


