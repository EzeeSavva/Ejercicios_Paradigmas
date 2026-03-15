class Niños inherits IntegranteDelTerror{
    var property caramelos = 0
    var property elementos = []
    var property actitud = 0
    var property salud = sano

    override method capacidadDeAsustar(){
        return self.cantidadElementos() * self.actitud()
    }

    method cantidadElementos(){
        return self.elementos().sum({elemento => elemento.cantidadSusto()})
    }

    method asustar(unAdulto){
        unAdulto.seAsustoPor(self)
    }

    override method recibirCaramelos(cantidad){
        caramelos += cantidad
    }

    method comerCaramelos(cantidad) {
        if (caramelos < cantidad){
            self.error("No tiene suficientes caramelos")
        }
        salud.comer(self, cantidad) 
        caramelos -= cantidad
    }
}

class Adulto{
    var property cantidadNiñosAnteriores = []
    method seAsustoPor(unNiño){
        if(self.loAsusta(unNiño)){
            unNiño.recibirCaramelos(self.caramelosAEntregar())
        }
    }
    method loAsusta(unNiño)

    method caramelosAEntregar() = self.tolerancia() / 2

    method tolerancia(){
        return 10 * self.cantidadNiñosAnteriores().count({niño => niño.caramelos() > 15})
    }



}

class Comun inherits Adulto{
    override method loAsusta(unNiño) = unNiño.capacidadDeAsustar() > self.tolerancia()

}

class Abuelo inherits Adulto{
    override method loAsusta(unNiño) = true

    override method caramelosAEntregar() = super() / 2

}


class Necios inherits Adulto{
    override method loAsusta(unNiño) = false

}

object maquillaje{
    method cantidadSusto() = 3

}

class Traje{
    method cantidadSusto()
}

class Tierno inherits Traje{
    override method cantidadSusto() = 2


}

class Terrorifico inherits Traje{
    override method cantidadSusto() = 5

    
}

class LegionesDelTerror inherits IntegranteDelTerror{
    var property miembros = []

    method crearLegion(unosMiembros) {
        if (unosMiembros.size() < 2) {
            self.error("Una legión debe tener al menos dos miembros")
        }
        miembros = unosMiembros
    }

    override method capacidadDeAsustar(){
        return self.miembros().sum({niño => niño.capacidadDeAsustar()})
    }

    method cantidadCaramelos(){
        return self.miembros().sum({niño => niño.caramelos()})
    }
    method asustar(unAdulto){
        unAdulto.seAsustoPor(self)
    }

    override method recibirCaramelos(cantidad) {
        self.lider().recibirCaramelos(cantidad)
    }

    method lider() = self.miembros().max({niño => niño.capacidadDeAsustar()})
}


class IntegranteDelTerror {
    method capacidadDeAsustar()
    method recibirCaramelos(cantidad)
    method caramelos()
}

class Barrio{
    var property todosLosNiños = []

    method tresNiñosConMasCaramelos(){
        return self.todosLosNiños().sortedBy({niño, otroNiño => niño.caramelos() > otroNiño.caramelos()}).take(3)
    }

    method elementosUsados(){
        return self.todosLosNiños().filter({niño => niño.caramelos() > 10}).flatMap({ niño => niño.elementos() }).asSet()
    }
}

