class Empleado{
    var property estamina = 0
    var property raza = Biciclopes
    var property rol =  Soldado 

    method danio() = rol.danioQueAporta(self)

    method estaminaMaxima()

    method hacerTarea(unaTarea){
        unaTarea.
    }

    method defenderSector(){
        rol.defender(self)
    }

    method arreglarMaquina(maquina){
        if(estamina >= maquina.complejidad()){
        rol.arreglar(maquina)
        }
    }
}

class Biciclopes inherits Empleado{
    const ojos = 2

    override method estaminaMaxima() = 10

    override method danio() = super()

}

class Ciclopes inherits Empleado{
    const ojos = 1
    override method estaminaMaxima() = false

    override method danio() = super() / 2

}

class Laboratorio{
    var property empleados = [] 

    method arreglarMaquina()
}

class Soldado{
    var property practica = 0

    method defender(empleado){
        practica += 2
    }

    method danioQueAporta(empleado) {
        return 10 + practica
    }

}

class Obrero{
    var property herramientas = []
    method defender(empleado) {
        // Los obreros no tienen lógica especial de defensa mencionada aún
    }
    method danioQueAporta(empleado) = 0

}

class Mucama{
    method defender(empleado) {
        self.error("Las mucamas no defienden sectores")
    }

    method danioQueAporta(empleado) = 0
}

object tarea{
    var property complejidad = 0


}

class Cientifico{
    
    method ordenar(empleado,unaTarea){
        empleado.hacerTarea(unaTarea)
    }
}