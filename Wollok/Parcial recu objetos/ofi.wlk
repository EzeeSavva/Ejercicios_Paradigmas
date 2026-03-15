class Empleado{
    var property aniosAntiguedad = 4
    var property cantidadHorasTrabajadas = 2
    var property diasLaborablesPromedio = 22
    var property diasEstudio = 0
    var property sucursalQueEsta = Sucursal
    var property cargo = Cargo
    var property motivacion = 0
    var property personalidad = Competitiva

    method sueldoMensual(){
    return cargo.sueldoBase(self) + 100 * aniosAntiguedad
    }

    method cantidadColegas(){
        return sucursalQueEsta.colegas().filter({colegas => colegas != self}).size()
    }

    method cambiarSucursal(otraSucursal){
        sucursalQueEsta = otraSucursal
    }

    method cantidadColegasQueCobranMas(){
        return sucursalQueEsta.colegas().count({colega=>colega.sueldoMensual() > self.sueldoMensual()})
    }

}

class Sucursal{
    var property colegas = [] 
    var property presupuesto = 1000

    method esViable(){
        return self.puedePagarTodo()
    }

    method puedePagarTodo(){
        return self.presupuesto() >= colegas.sum({persona => persona.sueldoMensual()})
    }

    method cambiarDeSucursal(unEmpleado){
        if(self.cumpleCondiciones(unEmpleado)){
            unEmpleado.sucursalQueEsta().eliminarEmpleado(unEmpleado)
            self.agregarEmpleado(unEmpleado)
            unEmpleado.cambiarSucursal(self)
        }
        else{
            self.error("Error, no es viable")
        }
    }

    method agregarEmpleado(unEmpleado){
        self.colegas().add(unEmpleado)
    }

    method cumpleCondiciones(unEmpleado){
        return unEmpleado.sucursalQueEsta().esViable() && unEmpleado.cantidadColegas() < 3
    }

}

class Cargo{

    method sueldoBase(unEmpleado){
        return self.sueldoPorHora(unEmpleado) * unEmpleado.cantidadHorasTrabajadas() * unEmpleado.diasLaborablesPromedio()
    }

    method sueldoPorHora(unEmpleado)
    
}

class Recepcionista inherits Cargo{

    method sueldoPorHora(unEmpleado) {
      return 15
    }
}

class Pasante inherits Cargo{
    override method sueldoBase(unEmpleado){
        var sueldoNormal = super(unEmpleado)
        return sueldoNormal - (self.sueldoPorHora(unEmpleado) * unEmpleado.cantidadHorasTrabajadas() * unEmpleado.diasEstudio())
    }

    method sueldoPorHora(unEmpleado){
        return 10
    }

}

class Gerente inherits Cargo{

    var property plus  = 2

    method sueldoPorHora(unEmpleado){
        return 8 * unEmpleado.cantidadColegas() + plus
    }
}


class VicepresidenteJunior inherits Gerente{
    override method sueldoPorHora(unEmpleado){
        return super(unEmpleado) * 1.03 
    }
}


class Competitiva{

    method calcularMotivacion(unEmpleado){
        return 100 - 10 * unEmpleado.cantidadColegasQueCobranMas()
    }
}

class Sociable{
    method calcularMotivacion(unEmpleado){
        return 15 * unEmpleado.cantidadColegas()
    }
}

class Indiferentes{
    method calcularMotivacion(unEmpleado){
      return 0
    }
}

class Compleja{
    method calcularMotivacion(unEmpleado){
        return unEmpleado.personalidad().sum({personalidad => personalidad.calcularMotivacion(unEmpleado)/2})
    }
}