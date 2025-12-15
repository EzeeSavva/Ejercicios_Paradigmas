import panelista.*


class Tematica{

    var property involucrados = []
    method puntoPorTematica(panelista){
        panelista.sumarPunto()
    }


    method cantidadInvolucrados(){
        return involucrados.size()
    }
}

class Filosofica inherits Tematica{

}

class Farandula inherits Tematica{
       override method involucrados(panelista){
        if(involucrados.contains(panelista)){
            involucrados.cantidadInvolucrados()
        }
        else{
            self.puntoPorTematica(panelista)
        }
    }
}

class Deportiva inherits Tematica{
    method puntajePorDeportiva(panelista){
        panelista.sacarVentaja()
        self.puntoPorTematica(panelista)
    }
}

class Economica inherits Tematica{

}

class Moral inherits Tematica {

}