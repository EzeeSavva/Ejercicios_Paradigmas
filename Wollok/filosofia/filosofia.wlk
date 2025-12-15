class Filosofo{
    var property nombre = "Albert"
    var property edad = 25 
    const property honorificos = #{"el cinico", "el sabio"} 
    var property actividades = []
    var property nivelIluminacion = 0
    var property diasVividos = 0

    method presentacion(){
        return self.honorificos().join(", ") + " " + self.nombre()
    }

    method estaEnLocorrecto(){
        return nivelIluminacion > 1000
    }

    method disminuirIluminacion(unaCantidad){
        nivelIluminacion -= unaCantidad
    }

    method aumentarIluminacion(unaCantidad){
        nivelIluminacion += unaCantidad
    }

    method agregarHonorifico(unHonorifico){
        self.honorificos().add(unHonorifico)
    }

    method vivirUnDia(){
        self.actividades().forEach({ actividad => actividad.hacerActividad(self)})
        diasVividos += 1
        if(diasVividos == 365){
            self.cumplirAño()
            diasVividos = 0
        }
    }
    
    method cumplirAño(){
            edad += 1
            self.aumentarIluminacion(10)
            if(self.edad() == 60){
                self.agregarHonorifico("El Sabio")
            }
    }


    method rejuvenecer(cantidadDias){
        diasVividos -= cantidadDias
    }




}
class TomarVino{
    method hacerActividad(unFilosofo){
        unFilosofo.disminuirIluminacion(10) 
        unFilosofo.agregarHonorifico("El Borracho")
    }
}

class JuntarseAgora{
    const property otroFilosofo

    method hacerActividad(unFilosofo){
        const puntos = otroFilosofo.nivelIluminacion() / 10
        unFilosofo.aumentarIluminacion(puntos)
    }
}


class AdmirarPaisaje{
    method hacerActividad(unFiloso){
        
    }
}

class MeditarBajoCascada{
    var property metrosCascada = 10
    method hacerActividad(unFilosofo){
        unFilosofo.aumentarIluminacion(10* metrosCascada)
    }
}


class PracticarDeporte{
    var property deporte = futbol
    method hacerActividad(unFilosofo){
        unFilosofo.rejuvenecer(deporte.cantidadDias() ** 2)
    }
}

object  futbol{
    method cantidadDias() = 1 
}

object polo{
    method cantidadDias() = 2
}

object waterPolo {
    method cantidadDias() = polo.cantidadDias() * 2
}

class Argumento{
    var property descripcion = []
    const property naturaleza
    
    method esEnriquecedor(){
        return naturaleza.esEnriquecedor(self)
    }

}

class Estoica{
    method esEnriquecedor(unArgumento){
        return true
    }
}

class Moralista{
    method esEnriquecedor(unArgumento){
        return unArgumento.descripcion().words().size() >= 10
    }
}

class Esceptica{
    method esEnriquecedor(unArgumento){
        return unArgumento.descripcion().endsWith("?")
    }
}

class Cinica{
    method esEnriquecedor(unArgumento){
        return 0.randomUpTo(100) < 30
    }
}

class NaturalezaCombinada inherits Argumento{
    const property naturalezas = [] 

    method esEnriquecedor(unArgumento){
        return naturalezas.all({naturaleza => naturaleza.esEnriquecedor(unArgumento)})
    }

}
class Partido {
    const property filosofo
    const property argumentos = []

    method esBuenFilosofo() {
        return filosofo.estaEnLoCorrecto()
    }

    method argumentosEnriquecedores() {
        return argumentos.filter({ arg => arg.esEnriquecedor() })
    }
}

class Discusion {
    const property partido1
    const property partido2

    method esBuena() {
        const filosofosOk = partido1.esBuenFilosofo() && partido2.esBuenFilosofo()

        const todosLosArgumentos = partido1.argumentos() + partido2.argumentos()
        
        const cantidadEnriquecedores = todosLosArgumentos.count({ arg => arg.esEnriquecedor() })
        
        const argumentosOk = cantidadEnriquecedores >= (todosLosArgumentos.size() * 0.5)

        return filosofosOk && argumentosOk
    }
}

class FilosofoContemporaneo inherits Filosofo {
    
    var property amaAdmirarPaisaje = false 

    override method presentacion() {
        return "hola"
    }

    override method nivelIluminacion() {
        if (self.amaAdmirarPaisaje()) {
            return super() * 5 
        } else {
            return super()
        }
    }
}
