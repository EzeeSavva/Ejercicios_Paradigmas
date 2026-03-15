class Riley{
    var property nivelFelicidad = 1000
    var property emocionDominante
    var property recuerdosDelDia = []
    var property pensamientosCentrales = #{}
    var property largoPlazo = []
    const property edad

    method vivirEvento(recuerdo){
        const nuevoRecuerdo = new Recuerdo(descripcion = recuerdo, fecha = new Date(),emocion = emocionDominante)
        recuerdosDelDia.add(nuevoRecuerdo)
        }

        method añadirPensamientoCentral(recuerdo){
            self.pensamientosCentrales().add(recuerdo)
        }

        method disminuirFelicidad(cantidad){
        if(self.nivelFelicidad() - cantidad < 1){
            self.error("Error, no puede tener felicidad negativa")
            }  
            nivelFelicidad -= cantidad
        }

        method ultimosRecuerdosDelDia(){
            return self.recuerdosDelDia().reverse().take(5)
        }

        method conocerPensamientosCentrales(){
            return self.pensamientosCentrales().asSet()
        }

        method pensamientoCentralDificil(){
            return self.pensamientosCentrales().filter({recuerdo => recuerdo.esDificil()})
        }

        method negarRecuerdo(recuerdo){
            return emocionDominante.niega(recuerdo)
        }

        method irADormir(palabraDada){
            self.asentarRecuerdoDia()
            recuerdosDelDia.filter({recuerdo => recuerdo.contains(palabraDada)}).forEach({recuerdo => recuerdo.asentar(recuerdo, self)})
            self.profundizacion()
            self.controlHormonal()
            self.restauracionCognitiva()
            self.liberarRecuerdos()
        }

        method asentarRecuerdoDia(){
            recuerdosDelDia.forEach({recuerdo => recuerdo.asentar(recuerdo, self)})
        }

        method profundizacion(){
            const recuerdosAEnviar = self.recuerdosDelDia().filter({recuerdo => !self.pensamientosCentrales().contains(recuerdo) && !self.negarRecuerdo(recuerdo)})
            largoPlazo.addAll(recuerdosAEnviar)
        }

        method controlHormonal(){
            if(self.tieneDesequilibrioHormonal()){
                self.disminuirFelicidad(nivelFelicidad * 0.15)
                self.pensamientosCentrales().asList().drop(3)
            }
        }

        method pensamientoEnLargoPlazo(){
           return pensamientosCentrales.any({pensamiento => largoPlazo.contains(pensamiento)})
        }

        method tieneDesequilibrioHormonal(){
            return self.pensamientoEnLargoPlazo() || self.recuerdosConMismaEmocion()
        }

        method recuerdosConMismaEmocion(){
            const primeraEmocionDeLaLista = recuerdosDelDia.first().emocion()
            return recuerdosDelDia.all({ r => r.emocion() == primeraEmocionDeLaLista})
        }

        method restauracionCognitiva(){
            self.aumentarFelicidad(100)
        }

        method aumentarFelicidad(cantidad){
            nivelFelicidad = (nivelFelicidad + cantidad).min(1000)
        }

        method liberarRecuerdos(){
            self.recuerdosDelDia().clear()
        }

        method rememorar() {
        const recuerdosCandidatos = largoPlazo.filter({ r => r.antiguedad() > (self.edad() / 2)})
        if (recuerdosCandidatos.isEmpty()){
            self.error("No se encontraron recuerdos tan antiguos")
        }
        const recuerdoElegido = recuerdosCandidatos.anyOne()
        self.añadirPensamientoCentral(recuerdoElegido)
        }
}
    


class Recuerdo{
    var property descripcion = "Hola"
    var property fecha = "10/12/2003"
    var property emocion

    method asentarse(riley){
        emocion.asentar(self,riley)
    }

    method volversePensamientoCentral(riley){
        riley.añadirPensamientoCentral(self)
    }

    method esDificil(){
        return self.descripcion().words().size() > 10
    }
    
    method antiguedad() = new Date().year() - fecha.year()
    
}

object alegria{
    method asentar(recuerdo,riley){
        if(riley.nivelFelicidad() > 500){
            recuerdo.volversePensamientoCentral(riley)
        }
    }

    method niega(recuerdo) = !recuerdo.esAlegre()

    method esAlegre() = true

}

object tristeza{
    method asentar(recuerdo,riley){
        recuerdo.volversePensamientoCentral(riley)
        riley.disminuirFelicidad(riley.nivelFelicidad() * 0.1)
    }
    method niega(recuerdo) =  recuerdo.esAlegre()

    method esAlegre() = false
    
}

object disgusto{
    method asentar(recuerdo, riley){

    }
    method niega(recuerdo){

    }
}

object temeroso{
    method asentar(recuerdo, riley){

    }
    method niega(recuerdo){
        
    }
}

object furioso{
    method asentar(recuerdo,riley){

    }
    method niega(recuerdo){
        
    }
}

