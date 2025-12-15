import src.Jugador.*


object banco {
  var dinero = 0

  method cobrar(monto){
    dinero += monto
  }
  method dineroActual(){
    return dinero
  }
  method cayo(unJugador, unaPropiedad){
    unJugador.pagarA(self, unaPropiedad.precioCompraInicial())
  }

  method esBanco()
  {
    return true
  }
}


class Propiedad {
    var property duenio = banco
    var precioCompraInicial = 0

    method cambiarDuenio(unJugador){
      duenio = unJugador
    }
    
    method precioCompraInicial(){return precioCompraInicial}
    // 7)
    method cayo(unJugador) {
      duenio.cayo(unJugador, self)
    }
  
    method rentaPara(jugadorQueCayo)

    method cantidadDuenios(){
      return self.cantidadDuenios()
    }

    method sosEmpresa(){
      return false
    }

    method paso(jugador){
    }

    method hipotecar() {
     duenio.cobrar(self.valorHipoteca())
     duenio = banco
    }

    method valorHipoteca(){
      return self.precioCompraInicial()/2
    }

}

class Campo inherits Propiedad{
  var rentaFija = 0 
  var cantidadEstancias = 0
  var costoConstruccion = 0
  var property provincia = Campo
   
  override method rentaPara(jugadorQueCayo) {
    //Campo tiene en cuenta la cantidad de estancias que tiene construidas
    return 2**(cantidadEstancias)* rentaFija
  }

  method construirEstancia() {
    provincia.validarConstruccion(self) duenio.debePagar()
    cantidadEstancias += 1
  }

  method debePagar() {
    duenio.pagarA(banco, costoConstruccion)
  }

  method cantidadDeEstancias(){
    return cantidadEstancias
  }

  override method valorHipoteca() {
  const valorBase = self.precioCompraInicial() / 2
  const valorEstancias = 2**(cantidadEstancias)* rentaFija / 2
  return valorBase + valorEstancias
}

}


class Provincia{
  var property campos = [] //sabe cuales son sus campos


  method agregarCampo(unCampo) {
    campos.add(unCampo)
  }

  method duenios() {
    return campos.map({campo => campo.duenio()})
  }

  method validarConstruccion(unCampo) {
    if (!self.esMonopolio()){
      throw new Exception(message = "No tiene monopolio en la provincia")
    }
    if (!self.construccionPareja(unCampo)){
      throw new Exception(message = "No cumple construcción pareja")
    }else{
      return true
    }
  }

  method esMonopolio() {
    return self.duenios().all({ c => c == self.duenios().first() })
  }

 method construccionPareja(unCampo) {
    // El campo donde se quiere construir debe tener <= cantidad de estancias que todos los demas
    return campos.all({ c => unCampo.cantidadDeEstancias() <= c.cantidadDeEstancias() })
  }

  method cantidadEstanciasProvincia() {
    return campos.sum({ c => c.cantidadDeEstancias() })
  }
}


class Empresa inherits Propiedad{
    var property tablero = null
  // Renta = X * 30000 * cantidad de empresas del dueño
  override method rentaPara(jugadorQueCayo) {
    return jugadorQueCayo.tirarDados() * 30000 * duenio.cantidadEmpresas()
  }

  override method sosEmpresa(){
    return true
    }
    
    method todasLasEmpresas(){ 
    return tablero.todasLasEmpresas()
    }
}



// el resto de los casilleros que no son salida
class Premio {
  method cayo(unJugador){
    self.darPremio(unJugador)
  }

  method darPremio(unJugador){
    unJugador.cobrar(2500)
  }
  
  method paso(jugador){
  }
}


// el unico casillero que es el de salida, representado como un objeto porque es unico
object salida { 
  method cayo(unJugador){
    // no hace nada
  }

  method paso(jugador){
    jugador.cobrar(5000)
  }

}

object prision{
  method cayo(unJugador){
  }

  method paso(unJugador){
  }
  
  method estaPreso(unJugador){
    return true
  }
    method liberar(unJugador) {
      unJugador.dejaDeEstarPreso()
    }
}
