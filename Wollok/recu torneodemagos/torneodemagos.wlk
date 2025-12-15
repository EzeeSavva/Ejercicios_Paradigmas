class Mago{
    var property poderInnato = 0
    var property objetosMagicos = []
    var property nombre = "Pepito"
    var property resistenciaMagica = 0
    var property categoria = new Aprendiz()
    var property energiaMagica = 100

    method poderTotal(){ 
        return self.poderTotalObjetos() * poderInnato
    }

    method poderTotalObjetos(){
        return self.objetosMagicos().sum({ objetomagico => objetomagico.poder(self)})
    }

    method nombreEsPar(){
        return self.nombre().length().even()
    }

    method disminuirEnergia(unaCantidad){
        energiaMagica -= unaCantidad
    }

    method aumentarEnergia(unaCantidad){
        energiaMagica += unaCantidad
    }

    method desafiar(otroMago) {
        // Le preguntamos al OTRO si se deja vencer por MÍ
        if (otroMago.esVencidoPor(self)) {
            // Lógica de robo de energía
            const energiaRobada = otroMago.energiaAEntregar()
            self.aumentarEnergia(energiaRobada)
            otroMago.disminuirEnergia(energiaRobada)
        }
    }

    method esVencidoPor(otroMago){
        return categoria.esVencido(self, otroMago)
    }

    method energiaAEntregar() {
        return categoria.energiaQuePierde(self)
    }

}

class Aprendiz{

    method esVencido(unMago, otroMago){
        return unMago.resistenciaMagica() < otroMago.poderTotal()
    }
    method energiaQuePierde(unMago) {
        return unMago.energiaMagica() / 2
    }

}

class Veterano{
    method esVencido(unMago,otroMago){
        return unMago.resistenciaMagica()*1.5 <= otroMago.poderTotal()
    }
    method energiaQuePierde(unMago){
        return unMago.energiaMagica() * 0.25
    }
}

class Inmortal{
    method esVencido(unMago, otroMago){
        return false
    }
}

class Varita{
    var property poderBase = 0

    method poder(unMago){
        if(unMago.nombreEsPar()){
            return self.poderBase() * 1.5
        }
        else
        return self.poderBase()
    }
}

class TunicaComun{

    method poder(unMago){
        return unMago.resistenciaMagica()*2
    }
}

class TunicaEpica inherits TunicaComun{  
    const property puntosFijos = 10

    override method poder(unMago){
        return super(unMago) + puntosFijos
    }
}

class Amuleto{
    const property poderUnico = 200
    method poder(unMago){
        return poderUnico
    }
}

object ojota {
    const property poderUnico = 10

    method poder(unMago){
        return unMago.nombre().length() * poderUnico
    }
}

class Gremios{
    var property miembros = []

    method initialize() {
        if (miembros.size() < 2) {
            self.error("Un gremio debe tener al menos 2 miembros")
        }
    }

    method poderTotal(){
        return self.miembros().sum({ miembro => miembro.poderTotal()})
    }

    method reservaMagica(){
        return self.miembros().sum({ miembro => miembro.energiaMagica() })
    }

    method resistenciaMagica(){
        return self.miembros().sum({miembro => miembro.resistenciaMagica()})
    }

    method desafiar(oponente) {
        if (oponente.esVencidoPor(self)) {
            const energiaGanada = oponente.energiaAEntregar()
            self.liderDelGremio().aumentarEnergia(energiaGanada)
            oponente.disminuirEnergia(energiaGanada)
        }
    }

    method esVencidoPor(atacante) {
        const defensaTotal = self.resistenciaMagica() + self.liderDelGremio().resistenciaMagica()
        
        return atacante.poderTotal() > defensaTotal
    }

    method energiaAEntregar() {
        return miembros.sum({ miembro => miembro.energiaAEntregar() })
    }

    method disminuirEnergia(cantidadIgnorada) {
        miembros.forEach({ miembro => miembro.disminuirEnergia(miembro.energiaAEntregar())})
    }

    method liderDelGremio(){
        return miembros.max({miembro => miembro.poderTotal()})

    }

}