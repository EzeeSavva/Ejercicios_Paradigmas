class Panelista{
    var puntosEstrella = 0
    
    method incrementarPuntos(){
    
    }
    method darRemate(){
        self.sumarPunto()
    }

    method opinarDe(unaTematica){
        self.sumarPunto()
    }

    method sumarPunto(){
        puntosEstrella + 1
    }

}


class Celebridad inherits Panelista{
    override method incrementarPuntos()
    {
        puntosEstrella + 3
    }

    override method opinarDe(unaTematica){
        var cantidadPuntosASumar = unaTematica.involucrados(self)
        puntosEstrella + cantidadPuntosASumar
    }

}

class Colorado inherits Panelista{

    method incrementarPuntos(gracia){
        puntosEstrella * (gracia*0.2)
        self.darRemate()

    }

}

class ColoradoPeluca inherits Panelista{
    method incrementarPuntos(gracia){
        Colorado.incrementarPuntos(gracia)
        puntosEstrella + 1
    }
}

class Viejo inherits Panelista{
    method incrementarPuntos(unaTematica){

    }
}

class PanelistaDeportivo inherits Panelista{
    override method incrementarPuntos(){

    }

    method sacarVentaja(){
        return puntosEstrella + 5
    }

    override method opinarDe(unaTematica){
        unaTematica.puntajePorDeportiva(self)
    }
}

