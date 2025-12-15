class Jugador{
    var property rol = new Tripulante()
    var property color = "Rojo"
    var property mochila = []
    var property nivelSospecha = 40
    var  property tareasARealizar = #{}

    method esSospechoso(){
       return nivelSospecha > 50
    }

    method buscarItem(){
        
    }
    
}


class Tripulante{

}

class Impostor{


}

object nave{
    var property jugadores = []




}