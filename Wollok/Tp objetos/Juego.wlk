import src.Tablero.*

class Juego {
  const property jugadores = []
  var property estaTerminado = false
  const property tablero

  method empezar() {
    if (not self.estaTerminado()) {
      jugadores.forEach { jugador => self.queJuegue(jugador) }
    }
  }

  // 9)
  method queJuegue(unJugador) {
  	var valorDados = unJugador.tirarDados()

    if(unJugador.estaPreso()){
      unJugador.tirarDadosPreso()
    }
    const recorrido = tablero.casillerosDesdeHasta(unJugador.casillero(), valorDados) 
    unJugador.moverSobre(recorrido)
  }
}
