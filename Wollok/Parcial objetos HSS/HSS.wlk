class Panelista{
    var property puntosEstrella = 0

    method darRemate(unaTematica){
        self.aumentarPuntos(self.puntosRemate(unaTematica))
        self.postRemate()
    }

    method aumentarPuntos(unosPuntos){
        puntosEstrella += unosPuntos
    }

    method postRemate(){

    }
    method puntosRemate(unaTematica)

    method puntosOpinionComun(){
        return 1    
    }

    method puntosOpinionDeportiva(){
        return self.puntosOpinionComun()
    }
 
    method puntosOpinionFarandulera(unFarandulero) = self.puntosOpinionComun()
}

class Celebridad inherits Panelista{
    override method puntosRemate(unaTematica){
        return 3
    }

    override method puntosOpinionFarandulera(unaTematica) = 
        if(unaTematica.estaInvolucrado(self)){
            unaTematica.cantidadInvolucrados()
        }
        else{
            self.puntosOpinionComun()
        }
}


class Colorado inherits Panelista{
    var property gracia = 0
    override method puntosRemate(unaTematica){
        return gracia / 5
    }

    override method postRemate(){
        gracia = gracia+ 1
    }
}


class ColoradoConPeluca inherits Colorado{

    override method puntosRemate(unaTematica){
        return super(unaTematica) + 1
    }

}

class Viejo inherits Panelista{
    override method puntosRemate(unaTematica){
        return unaTematica.cantidadPalabrasTitulo()
    }

}

class Deportivo inherits Colorado{
    override method puntosRemate(unaTematica){
        return 0
    }

    override method puntosOpinionDeportiva(){
        return 5
    }
}


class Tematica{
    method esInteresante() = false

    var property titulo = "asdd"


    method cantidadPalabras() = titulo.words().size()

    method puntosPorOpinion(unPanelista) = unPanelista.puntosOpinionComun(self)

}

class Filosofica inherits Tematica{
    override  method esInteresante(){
        return self.cantidadPalabras() > 20
    }
    
}

class Farandula inherits Tematica{ 
    const involucrados = []
    method cantidadInvolucrados() =   involucrados.size()

    override method esInteresante() =  self.cantidadInvolucrados() > 3

}


class Deportiva inherits Tematica{
    override method esInteresante() = titulo.contains({"Messi"})
}

class TematicaMixta inherits Tematica{
    var property tematicas = []

    override method puntosPorOpinion(unPanelista) = tematicas.sum({tematica => tematica.puntosPorOpinion(unPanelista)})
    
    override method esInteresante() = tematicas.any({tematica => tematica.esInteresante()})
}


