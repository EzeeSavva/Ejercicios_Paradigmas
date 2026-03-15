class Pajaro{
    var property ira = 0
    var property cantidadEnojos = 0
    
    method fuerza() = ira*2


    method enojarse(){
        ira = ira * 2
        cantidadEnojos += 1
    }

    method disminuirIra(cantidad){
        ira -= cantidad
    }

    method impactar(unaEstructuraOCerdito, islaCerdito){
        if(self.fuerza() > unaEstructuraOCerdito.resistencia()){
            self.derribar(unaEstructuraOCerdito,islaCerdito)
        }
    }

    method derribar(unaEstructuraOCerdito,islaCerdito){
        islaCerdito.romperse(unaEstructuraOCerdito)
    }

    method sePuedenRecuperarHuevos(islaCerdito){
        return islaCerdito.quedoLibreDeObstaculos()
    }

}

class Red inherits Pajaro{
    override method fuerza() = ira * 10 * self.cantidadEnojos()

}

class Bomb inherits Pajaro{
    
    var property tope = 9000
    override method fuerza() = super().min(tope)
}

class Chuck inherits Pajaro{
    var property velocidad = 0

override method fuerza() {
        if (velocidad <= 80) return 150
        return 150 + 5 * (velocidad - 80)
    }

    override method enojarse(){
        super()
        velocidad = velocidad * 2
    }

    override method disminuirIra(cantidad){

    }

}

class Terence inherits Pajaro{
    var property multiplicador  = 0
    override method fuerza(){
        return ira * self.cantidadEnojos() * self.multiplicador()
    }
}

class Matilda inherits Pajaro{
    var property huevos = []
    override method fuerza() {
        return super() + self.huevos().sum({huevo => huevo.fuerza()})
    }

    override method enojarse(){
        super()
        huevos.add(new Huevo(peso = 2))
    }
}

class Huevo{
    var property peso = 0
    method fuerza() = peso
}

class Isla{
    var property pajaros = []
    var property homenajeados = []

        method pajarosMasFuertes(){
            return pajaros.filter({pajaro => pajaro.fuerza() > 50})
    }

    method fuerzaDeLaIsla(){
        return self.pajarosMasFuertes().sum({pajaro => pajaro.fuerza()})
    }

}

class IslaPajaro inherits Isla{
        method sesionDeManejoDeIra(){
        self.disminuirIraDeTodos()
    }

    method disminuirIraDeTodos(){
        self.pajaros().forEach({pajaro => pajaro.disminuirIra(5)})
    }

    method invasionDeCerditos(cantidadDeCerditos){
        const cantidadDeVecesQueSeEnojan = cantidadDeCerditos.div(100)
        self.pajaros().forEach({pajaro => cantidadDeVecesQueSeEnojan.times({i => pajaro.enojarse()})})
    }

    method fiestaSorpresa(){
    if(homenajeados.isEmpty())
    {
        self.error("No se sabe que pasa!")
    }
    self.homenajeados().forEach({pajaro => pajaro.enojarse()})

    }

    method serieDeEventosDesafortunados(cantidadDeCerditos){
        self.sesionDeManejoDeIra()
        self.invasionDeCerditos(cantidadDeCerditos)
        self.fiestaSorpresa()
    }

    method enviarPajaro(unaEstructura){
        const unPajaro = pajaros.anyOne()
        unPajaro.impactar(unaEstructura)
    }
}

class IslaCerdito inherits Isla{
    var property cerditos = []
    var property estructuras = []

    method romperse(unaEstructuraOCerdito){
        estructuras.remove(unaEstructuraOCerdito)
    }

    method quedoLibreDeObstaculos(){
        return self.estructuras().isEmpty()
    }

}

class Estructura{
    var property anchoPared = 0
    method resistencia()

}


class ParedDeVidrio inherits Estructura{
    override method resistencia() = 10 * anchoPared
}

class ParedDeMadera inherits Estructura{
    override method resistencia() = 25 * anchoPared
}

class ParedDePiedra inherits Estructura{
    override method resistencia() = 50 * anchoPared
}


class Cerdo{
    var property huevosRobados = [] 
    var property casco = 0 
    var property escudo = 0

    method resistencia()

    method tieneCasco() = !casco.isEmpty()
}

class Obrero inherits Cerdo{
    override method resistencia() = 50

}

class Armado inherits Cerdo{
    override method resistencia() = if(self.tieneCasco()) 10* self.casco() else 10* self.escudo()
}   
