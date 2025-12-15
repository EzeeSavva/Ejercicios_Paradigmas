class Tablero {
  const property casilleros = []
  method casillerosDesdeHasta(unCasillero, unNumero) {
    return self.casillerosDesde(casilleros.copy(), unCasillero).take(unNumero)
  }

  method casillerosDesde(unosCasilleros, unCasillero) {
    const primero = unosCasilleros.first()
    unosCasilleros.remove(primero) // Remueve el primero
    unosCasilleros.add(primero)    // Lo agrega al final
    return if (primero == unCasillero) unosCasilleros
           else self.casillerosDesde(unosCasilleros, unCasillero)
  }

  method todasLasEmpresas() {
        // Filtra la lista total de casilleros y devuelve solo aquellos que son Empresas
        return casilleros.filter({ casillero => casillero.sosEmpresa() })
    }
}
