%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchicas(Marca,Cantidad)
precioUnitario(arroz(gallo),25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).

%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).


%1.
tieneDescuento(descuento(arroz(Marca), 1.50)) :-
    precioUnitario(arroz(Marca), _).

% Regla: las salchichas tienen 0.50 de descuento salvo que la marca sea vienisima
tieneDescuento(descuento(salchichas(Marca, Cantidad), 0.50)) :-
    precioUnitario(salchichas(Marca, Cantidad), _),
    Marca \= vienisima.

tieneDescuento(descuento(lacteo(Marca, leche), 2)) :-
    primeraMarca(Marca),
    precioUnitario(lacteo(Marca,leche),_).

tieneDescuento(descuento(Producto, Descuento)) :-
    precioUnitario(Producto, Precio),
    esElMasCaro(Precio),
    Descuento is Precio * 0.5.

esElMasCaro(Precio) :-
    forall(precioUnitario(_, OtroPrecio), Precio >= OtroPrecio).


% Un cliente es comprador compulsivo si compró todos los productos de primera marca con descuento
esCompradorCompulsivo(Cliente) :-
  forall(productoPrimeraMarcaConDescuento(Producto), compro(Cliente, Producto, _)).

% Caso arroz
productoPrimeraMarcaConDescuento(arroz(Marca)) :-
    primeraMarca(Marca),
    tieneDescuento(descuento(arroz(Marca), _)).

% Caso lácteos
productoPrimeraMarcaConDescuento(lacteo(Marca, Tipo)) :-
    primeraMarca(Marca),
    tieneDescuento(descuento(lacteo(Marca, Tipo), _)).

% Caso salchichas
productoPrimeraMarcaConDescuento(salchichas(Marca, Cantidad)) :-
    primeraMarca(Marca),
    tieneDescuento(descuento(salchichas(Marca, Cantidad), _)).

totalAPagar(Cliente,Total):-
    findall(PrecioFinal, precioFinal(Cliente,PrecioFinal),ListaPrecios),
    sum_list(ListaPrecios, Total).
    

precioFinal(Cliente, TotalCompraCliente):-
    compro(Cliente, Producto, CantidadComprada),
    precioUnitario(Producto, PrecioUnitario),
    tieneDescuento(descuento(Producto,Descuento)),
    TotalCompraCliente is ((PrecioUnitario - Descuento) * CantidadComprada).

precioFinal(Cliente, TotalCompraCliente):-
    compro(Cliente, Producto, CantidadComprada),
    precioUnitario(Producto, PrecioUnitario),
    not(tieneDescuento(descuento(Producto,Descuento))),
    TotalCompraCliente is ((PrecioUnitario - 0) * CantidadComprada).


clienteFiel(Cliente, Marca) :-
    forall(compro(Cliente, Producto, _),(productoDeMarcaOControlada(Producto, Marca))).

productoDeMarcaOControlada(arroz(MarcaProd), Marca) :-
    mismaMarca(MarcaProd,Marca)

productoDeMarcaOControlada(lacteo(MarcaProd, _), Marca) :-
    mismaMarca(MarcaProd, Marca).

productoDeMarcaOControlada(salchichas(MarcaProd, _), Marca) :-
    mismaMarca(MarcaProd, Marca).

mismaMarcaOMarcaControlada(MarcaProd, Marca) :-
    dueñoTransitivo(Marca, MarcaProd). 

mismaMarca(Marca, Marca).

duenioTransitivo(Marca, Marca2) :-
    duenio(Marca, Marca2).

duenioTransitivo(Marca, Marca2) :-
    duenio(Marca, MarcaIntermedia),
    duenioTransitivo(MarcaIntermedia, Marca2).

%Se agrega el predicado dueño que relaciona dos marcas siendo que la primera es dueña de la otra.
duenio(laSerenisima, gandara).
duenio(gandara, vacalín).

provee(Empresa, Productos) :-
    findall(Producto, (precioUnitario(Producto, _), productoDeEmpresaOControlada(Producto, Empresa)), ListaProductos),
    sum_list(ListaProductos, Productos).

