class Cargo {
    method sueldoPorHora(persona)

    method sueldoBaseMensual(persona) = self.sueldoPorHora(persona) * persona.horasPorDia() * persona.diasLaborables()
    
}

class Recepcionista inherits Cargo {
    override method sueldoPorHora(persona) = 15
}

class Pasante inherits Cargo {
    var diasDeEstudio

    override method sueldoPorHora(persona) = 10 

    override method sueldoBaseMensual() = self.sueldoPorHora(persona) * persona.horasPorDia() * (22 - diasDeEstudio)
}

class Gerente inherits Cargo {
    var plus 

    override method sueldoPorHora(persona) = 8 * persona.cantidadDeColegas() + plus 
}

class VicepresidenteJunior inherits Gerente {

    override method sueldoPorHora(persona) = super() + 1.03
}

class Sucursal { 
    var presupuestoMensual
    var property empleados = #{}

    method presupuestoNecesario() = empleados.sum(empleado => empleado.sueldoBaseMensual())

    method esViable() = slef.presupuestoNecesario() <= presupuestoMensual

    method transferir(empleado, otraSucursal) {
        if(otraSucursal.esViable() && self.cantidadDeEmpleados() >= 3) {
            otraSucursal.agregarEmpleado(empleado)
            empleados.remove(empleado)
            persona.cambiarDeSucursal(otraSucursal) 
        }
        else {
            self.error("No puede ser transferido el empleado")
        }
    }

    method cantidadDeEmpleados() = empleados.size()

    method agregarEmpleado(unEmpleado) {
        empleados.add(unEmpleado)
    }

    method cantidadDeColegasQueCobranMas(sueldo) = empleados.count({empleado => empleado.sueldoBaseMensual() > sueldo})
}

class Persona {
    var cargo 
    var sucursal 
    const personalidad 
    var antiguedad 
    var property horasPorDia
    var property diasLaborables
   
    method sueldoMensual() = cargo.sueldoBaseMensual(self) + 100 * antiguedad

    method cantDeColegas = sucursal.cantidadDeEmpleados() - 1

    method cambiarDeSucursal(otraSucursal) {
        sucursal = otraSucursal
    }

    method cambiarCargo(nuevoCargo) {
        cargo = nuevoCargo
    }

    method motivacion() = personalidad.motivacion(self).between(0,100)
}

class Competitiva {
    method motivacion(persona) = 100 - 10 * persona.sucursal.cantidadDeColegasQueCobranMas(sueldo)
}

class Sociable {
    method motivacion(persona) = 15 * persona.sucursal.cantidadDeEmpleados()
}

class Indiferente {
    const motivacionFija 

    method motivacion(persona) = motivacionFija
}

class Compleja {
    var personalidades = []

    method motivacion(persona) = sumaDePersonalidades() / cantidadDePersonalidades

    method cantidadDePersonalidades() = personalidades.size()

    method sumaDePersonalidades() = personalidades.sum(personalidad => personalidad.motivacion(persona))
}


