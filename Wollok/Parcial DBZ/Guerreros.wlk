class Guerrero{
    var property potencial
    var property experiencia
    var property energia = energiaMaxima
    const property energiaMaxima
    var property tipoDeTraje


    method morir(){
        potencial = 0
        experiencia = 0
        energia = 0
    }

    method atacar(otroGuerrero){
        var danio = self.potencial() * 0.10
        otroGuerrero.danioSufrido(danio)
    }

    method danioSufrido(danio){
        var nuevoDanio = tipoDeTraje.disminuirDanio(danio)
        self.perderEnergia(nuevoDanio)
        tipoDeTraje.desgastar()  
        tipoDeTraje.aumentarExp(self)
    }


    method perderEnergia(danio){
       energia = energia - danio
    }

    method comerSemilla(unGuerrero){
        unGuerrero.restaurarEnergia()
    }

    method restaurarEnergia(){
        energia = energiaMaxima
    }

    method aumentarExperiencia(cantidad){
        experiencia * cantidad
    }
    
}

class Traje{ 
    const property proteccion = 0.3
    var property desgaste = 0
    
    method disminuirDanio(){

    }

    method aumentarExp(unGuerrero){
        unGuerrero.aumentarExperiencia(1)
    }

    method desgastar(){
        desgaste = desgaste + 5
    }

    method estaGastado(){
        return self.desgaste() >= 100
    }

}

class TrajeComun inherits Traje{

    method disminuirDanio(danio){
        if(self.estaGastado()){
            return danio
        }
        return danio * (1- self.proteccion())
    }
}

class TrajeEntrenamiento inherits Traje{

    method disminuirDanio(danio){
        
    }

    override method aumentarExp(unGuerrero){
        unGuerrero.aumentarExperiencia(2)
    }

}


class TrajeModularizado inherits Traje{
    var property piezas = [] 
    method disminuirDanio(danio){
        
    }
    override method aumentarExp(unGuerrero){
        if(self.cantidadPiezasGastadas() == 0){
            unGuerrero.aumentarExp(1)
        }
        else if(self.cantidadPiezasGastadas() == 2){
            unGuerrero.aumentarExp(0.2)
        }
        else{
            unGuerrero.aumentarExp(0.5)
        }
    }

    method cantidadPiezasGastadas(){
       return  self.piezas().count{ pieza => pieza.estaGastado()}
    }


    method cantidadPiezas(){
        return self.piezas().size()
    }

    override method estaGastado(){
       return self.piezas().all{ pieza => pieza.estaGastado() }
    }

}

class Pieza {
    const property porcentajeResistencia
    var property desgaste = 0
    
    method desgastar() {
        desgaste += 5
    }

    method estaGastado() = self.desgaste() >= 20
}




