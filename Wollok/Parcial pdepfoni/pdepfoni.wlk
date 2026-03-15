class Linea{
    var property numeroTelefono = 1
    var property packs = []
    var property consumosRealizados = []

    method consumosTotales() = consumosRealizados.sum({costos => costos.costo() })

}


class Consumo {
    var property fecha = new Date()
    
    method costo()
}

class ConsumoInternet inherits Consumo {
    var property mbConsultados
    
    override method costo() = mbConsultados * pdepfoni.precioPorMB()
}

class ConsumoLlamada inherits Consumo {
    var property segundos
    
    override method costo() {
        return if (segundos <= 30) {
            pdepfoni.precioFijoLlamada()
        } else {
            pdepfoni.precioFijoLlamada() + (segundos - 30) * pdepfoni.precioPorSegundo()
        }
    }
}

object pdepfoni {
    var property precioPorMB = 0.10
    var property precioPorSegundo = 0.05
    var property precioFijoLlamada = 1
}

class Pack{
    var property vigencia = 11 
}