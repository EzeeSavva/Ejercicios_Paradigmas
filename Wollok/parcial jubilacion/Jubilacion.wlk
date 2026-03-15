class Empresa{
    var property personal = []
    method obtenerListaInvitados(){
        return personal.filter({persona => persona.esInvitado()})
    }
}

class Invitado{
    var property lenguajes = []
    var property añosExperiencia = 0
    var property mesaAsignada = 0
    
    method esInvitado() = self.esCopado()

    method esCopado()

    method sabeLenguajeAntiguo() = lenguajes.any({ lenguaje => lenguaje.esAntiguo() })
    method sabeLenguajeModerno() = lenguajes.any({ lenguaje => !lenguaje.esAntiguo() })

    method aprenderLenguaje(unLenguaje){
        self.lenguajes().add(unLenguaje)
    }

    method irAMesa(){
        mesaAsignada = self.cantidadLenguajesModernosQueSabe()
    }

    method cantidadLenguajesModernosQueSabe(){
        return self.sabeLenguajeModerno().count({lenguaje => !lenguaje.esAntiguo()})
    }

    method regalarEfectivo() =  1000 * self.cantidadLenguajesModernosQueSabe()
}


class Desarrollador inherits Invitado{
    override method esInvitado(){
        return super() || self.sabeProgramarWollok()
    }

    method sabeProgramarWollok(){
        return self.lenguajes().contains("Wollok") || self.lenguajes().any({lenguaje => lenguaje.esAntiguo()})
    }
    override method esCopado(){
        return self.sabeLenguajeAntiguo() && self.sabeLenguajeModerno()
    }
}

class Infraestructura inherits Invitado{
    method tieneMasDe5Lenguajes() = self.lenguajes().size() >= 5

    override method esInvitado() = super() || self.tieneMasDe5Lenguajes()

    override method esCopado(){
        return self.añosExperiencia() > 10
    }
}


class Jefe inherits Invitado{
    var property personasACargo =[]
    override method esInvitado() = super() || (self.sabeLenguajeAntiguo() && self.tieneACargoGenteCopada())

    method tieneACargoGenteCopada(){
        return self.personasACargo().all({persona => persona.esCopado() })
    }

    method tomarACargo(unEmpleado){
        personasACargo.add(unEmpleado)
    }

    override method irAMesa(){
        mesaAsignada = 99
    }

    override method regalarEfectivo(){
        return super() + 1000 * self.personasACargo().size()
    }


    



}

object fiesta{
    const salon = 200000
    const property invitados = []
    var property asistentes = [] 
    var property balanceRegalos = 0
    var property balanceTotal = 0

    method costoTotal() =  salon + (asistentes.size() * 5000)

    method lleganInvitado(unInvitado){
        self.verificarInvitado(unInvitado)
        self.generarRegistroAsistencia(unInvitado)
    }

    method verificarInvitado(unInvitado) = if(!invitados.contains(unInvitado)) self.error("No esta invitado!") else asistentes.add(unInvitado)

    method generarRegistroAsistencia(unInvitado){
        unInvitado.irAMesa()
    }

    method esAsistente(unInvitado){
        return asistentes.contains(unInvitado)
    }

    method recibirRegalo(unInvitado){
        balanceRegalos += unInvitado.regalarEfectivo()
    }

    method balanceDeLaFiesta(){
        balanceTotal = balanceRegalos - self.costoTotal()
    }

    method fueExitosa() = balanceTotal > 0 && self.asistieronTodos()

    method asistieronTodos(){
        return invitados.size() == asistentes.size()
    }    

    method mesaConMasAsistentes(){
        const mesas  = self.asistentes().map({invitado => invitado.mesaAsignada()})

        return mesas.max({mesa => mesas.ocurrencesOf(mesa)})
    }

}

