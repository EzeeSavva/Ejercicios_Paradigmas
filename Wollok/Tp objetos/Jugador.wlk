import src.Propiedad.*
import src.Tablero.*
class Jugador{   
    var dinero = 0
    var empresas = []
    var campos = []
    var cantidadDobles = 0
    var turnosPreso = 0
    var estaPreso = false
    var casilleroActual = salida
    var dado = dadoNormal

    method casillero(){
        return casilleroActual
    }
    method casillero(otrocasillero){
        casilleroActual = otrocasillero
    }

    method poseeDinero(){
        return dinero > 0
    }
    method cobrar(monto){
        dinero += monto
    }

    method dineroActual(){
        return dinero
    }

    /*method cantidadCampos(){
        return campos.size()
    }*/

    //2) Cantidad de empresas

    method cantidadEmpresas(){
        return empresas.size()
    }
    //El agregar empresa lo hice para hacer el test, no se si se usa
    method agregarEmpresa(empresa){
        empresas.add(empresa)
        empresa.cambiarDuenio(self)
    }

    method agregarCampo(campo){
        campos.add(campo)
        campo.cambiarDuenio(self)
    } 

    method cayo(unJugador, unaPropiedad){
        if (self != unJugador) unJugador.pagarA(self, unaPropiedad.rentaPara(unJugador))
    }
     
    //3) Hacer que un jugador entienda el mensaje tirarDados. Esto devuelve una cantidad que es la suma de dos números aleatorios entre 1 y 6. 

    method tirarDados(){
        return dado.girar()
    }

    //5) Hacer que un jugador pague una suma de dinero a un acreedor; si no tiene dinero suficiente se debe lanzar un error.
    //Cuando un jugador paga a otro, su dinero disminuye y el del acreedor aumenta. Los jugadores y el banco deben ser polimórficos.
    //Teniendo en cuenta punto 3 de la extensión, queda de esta manera:


    method pagarA(alguien, monto){
            if(self.puedePagar(monto)){
                self.pagar(alguien, monto)
            } else {
                self.hipotecarHastaCubrir(monto)
                if(self.puedePagar(monto)){
                self.pagar(alguien, monto)
                } else {
                throw new Exception(message = "no puede pagar ni hipotecando todo el pobre tipo")
                }
            }
    }

        method pagar(alguien, monto){
                dinero -= monto
                alguien.cobrar(monto)
            }

        method puedePagar(monto){
            return dinero >= monto
        }

        
        method hipotecarHastaCubrir(monto) {
           self.propiedades().forEach({ propiedad => if (!self.puedePagar(monto)) {propiedad.hipotecar()}})
        }
      
        method propiedades() {
           const todas = []                      
           empresas.forEach({ empresa => todas.add(empresa) })  
           campos.forEach({ campo => todas.add(campo) })  
           return todas
        }

        

    /*8)
    Hacer que un jugador se mueva sobre una colección de casilleros que le llega por parámetro. Esto hace que:
        El jugador pase por todos los casilleros de esa colección
        El jugador caiga en el último casillero de esa colección
        El casillero actual del jugador sea el último casillero de esa colección
    */
    method moverSobre(casilleros){
        casilleros.forEach({casillero => casillero.paso(self)})
        casilleros.last().cayo(self)
        casilleroActual = casilleros.last()
    }

    //extension 1)
    method estaPreso(){
        return estaPreso
    }

    method irAPrision(casilleroPrision){
        self.casillero(casilleroPrision)
        estaPreso = true
        turnosPreso = 0
        cantidadDobles = 0
    }

    method turnosPreso(){
        return turnosPreso
    }


    method debeJugar() {
        self.tirarDadosPreso()
    }
    
    method cumplirTurnoPreso() {
        if(self.estaPreso()){
            turnosPreso = turnosPreso + 1
            if(turnosPreso >= 3) {
                self.dejaDeEstarPreso() // Sale por tiempo
            }
        }
    }
    
    method dejaDeEstarPreso() {
        estaPreso = false
        turnosPreso = 0
        cantidadDobles = 0
    }

    method tirarDadosPreso() {
        const dado1 = 1.randomUpTo(6)
        const dado2 = 1.randomUpTo(6)
        
        if (dado1 == dado2) {
            self.dobleEnDados()
        } else {
            cantidadDobles = 0
        }
        return dado1 + dado2
    }
    
    method dobleEnDados() {
        cantidadDobles = cantidadDobles + 1

        if (cantidadDobles == 2) {
            self.irAPrision(prision)
        } else if (self.estaPreso()) { //Si estaba preso y saco doble, se libera
            self.dejaDeEstarPreso()
            // Y sigue jugando su turno
        }
    }

    method esBanco()
  {
    return false
  }
}

class Dado{
    method girar() {
        return 1.randomUpTo(6).round() + 1.randomUpTo(6).round() 
    }
}

const dadoNormal = new Dado()

object dadoFijo5 inherits Dado{ 
    override method girar() {
        return 5
    }
}


class Estrategia{
    method debeComprar(unJugador,unaPropiedad){
    }
}


class Standar inherits Estrategia{
    override method debeComprar(unJugador,unaPropiedad){
        return unaPropiedad.duenio().esBanco()
    }
}
class Garca inherits Estrategia {
        override method debeComprar(jugadorQueCae, propiedadQueCae) {
        if(!propiedadQueCae.sosEmpresa()){  
            const provincia = propiedadQueCae.provincia()
            return provincia.campos().any({ campo => not campo.duenio().esBanco() and campo.duenio() != jugadorQueCae})
        }          
       if (propiedadQueCae.sosEmpresa()) {
            return propiedadQueCae.todasLasEmpresas().any({ empresa => (empresa != propiedadQueCae && !empresa.duenio().esBanco() && empresa.duenio() != jugadorQueCae)})
        }
        return false
    }
}

class Imperialista inherits Estrategia {
    override method debeComprar(jugadorQueCae, propiedadQueCae) {
        
        if (!propiedadQueCae.sosEmpresa()) {
            const provincia = propiedadQueCae.provincia()
            const camposProvincia = provincia.campos()
            
            // Condición A: El jugador ya tiene algún otro campo en esa provincia
            const yaTieneOtro = camposProvincia.any({ campo => campo.duenio() == jugadorQueCae and campo != propiedadQueCae})
            
            // Condición B: O todos los campos de esa provincia (incluyendo el actual) son del banco.
            const todosDelBanco = camposProvincia.all({ campo => campo.duenio().esBanco()})
            
            return yaTieneOtro or todosDelBanco
        }
        
        else if(propiedadQueCae.sosEmpresa()) {
            return propiedadQueCae.todasLasEmpresas().all({ empresa => empresa.duenio().esBanco()})
        }else{
            return false
        }
         
    }
}
