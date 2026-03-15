class Usuario{
    var property suscripcionActual = base
    var property saldo = 0
    var property humor = 0

    method filtrarJuegos(gameflix, unaCategoria){
        gameflix.filtrar(unaCategoria)
    }
    method buscarJuego(gameflix, nombreJuego){
        gameflix.buscar(nombreJuego)
    }

    method obtenerRecomendacion(gameflix){
        gameflix.recomendar()
    }

    method reducirSaldo(unaCantidad){
        saldo -= unaCantidad

    }

    method puedePagar(unaSuscripcion){
        if((saldo - unaSuscripcion.precio()) > 0){
            self.reducirSaldo(unaSuscripcion.precio())
        }
        else{
            self.error("No tiene dinero suficiente para pagar la suscripcion")
        }
    }

    method cambiarSuscripcion(unaSuscripcion){
        suscripcionActual = unaSuscripcion
    }

    method jugarJuego(unJuego, horasJugadas){
        if(suscripcionActual.permiteJugar(unJuego)){
            unJuego.afectar(self,horasJugadas)
        }
    }

    method reducirHumor(unaCantidad){
        humor -= unaCantidad
    }

    method aumentarHumor(unaCantidad){
        humor += unaCantidad
    }


    method comprarSkins(unaCantidad){
        if((saldo - unaCantidad) >=  0){
            self.reducirSaldo(unaCantidad)
        }else{
            self.error("No puede comprar Skins")
        }
    }
}



class Gameflix{
    var property todosLosJuegos = []

    method filtrar(unaCategoria){
        return todosLosJuegos.filter({juego => juego.categoria() == unaCategoria})
    }

    method buscar(nombreJuego){
        /*const juegosEncontrados = todosLosJuegos.filter({juego => juego.nombre() == nombreJuego})
        if(juegosEncontrados.isEmpty()){
            self.error("No existe ningun juego con ese nombre")
        }
        return juegosEncontrados.first()*/
        return todosLosJuegos.find({juego => juego.nombre() == nombreJuego},{self.error("No se encontro el juego")})
    }

    method recomendar(){
        return todosLosJuegos.anyOne()
    }

    method cobrarSuscripcion(unUsuario){
        const unaSuscripcion = unUsuario.suscripcionActual()
        if(unUsuario.puedePagar(unaSuscripcion)){
            unUsuario.cambiarSuscripcion(unaSuscripcion)
        }
        else{
            unUsuario.cambiarSuscripcion(prueba) 
        }
    }

}

class Juego{
    var property nombre = ""
    var property precio = 0
    var property categoria = "Infantil"

    method afectar(unaPersona,horasJugadas)

    
}

class Violento inherits Juego{
    override method afectar(unaPersona,horasJugadas){
        unaPersona.reducirHumor(10*horasJugadas)
    }
}

class MOBA inherits Juego{
    override method afectar(unaPersona,horasJugadas){
        unaPersona.comprarSkins(30)
    }
}

class Terror inherits Juego{
    override method afectar(unaPersona,horasJugadas){
        unaPersona.cambiarSuscripcion(infantil)
    }
}

class Estrategicos inherits Juego{
    override method afectar(unaPersona,horasJugadas){
        unaPersona.aumentarHumor(5* horasJugadas)
    }
}


object premium{
    method precio() = 50

    method permiteJugar(unJuego) = true
}

object base{
    method precio() = 25

    method permiteJugar(unJuego) = unJuego.precio() < 30

}

object infantil{
    method precio() = 10

    method permiteJugar(unJuego) = unJuego.categoria() == "Infantil"
}

object prueba{
    method precio() = 0

    method permiteJugar(unJuego) = unJuego.categoria() == "Demo"
}

