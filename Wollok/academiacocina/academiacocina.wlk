
class Receta{
    var ingredientes = []
    var property nivelPreparacion = 0
    var property experiencia = 0

    method cantidadIngredientes(){
        return ingredientes.size()
    }

    method esDificil(){
        return nivelPreparacion > 5 || ingredientes.size() > 10
    }

    method calcularExperiencia(){
        return self.cantidadIngredientes() * nivelPreparacion
    }
}

class Cocinero{
    var property experiencia = 0
    var nivelAprendizaje = new Principiante()
    var property preparaciones = []

    method puedePreparar(unaReceta){
        return nivelAprendizaje.puedePreparar(unaReceta)
    }

    method preparar(unaComida){
        if (self.puedePreparar(unaComida.receta())) { 
            // Si dio TRUE, entra acá:
            preparaciones.add(unaComida)
            experiencia += unaComida.experienciaQueAporta() // O lo que diga la logica
        } else {
            // Si dio FALSE, podés tirar error o no hacer nada
            self.error("No me da el nivel para esta receta :(")
        }
    }

    method comidasDificiles() {
        return preparaciones.count({ comida => comida.receta().esDificil() })
    }

}

class NivelAprendizaje{
    method puedePreparar(unaReceta, unCocinero){

    }
    method superoNivel(unCocinero){
        
    }
}

class Principiante inherits NivelAprendizaje {
    override method puedePreparar(unaReceta, unCocinero){
        return not unaReceta.esDificil()
    }

    override method superoNivel(unCocinero){
        return unCocinero.experiencia() > 100
    }

}

class Experimentado inherits NivelAprendizaje{
override method puedePreparar(unaReceta, unCocinero) {
        return unCocinero.preparaciones().any({ platoPrevio => self.sonSimilares(unaReceta, platoPrevio.receta())})
        }

        method sonSimilares(recetaNueva, recetaPrevia) {
            return self.tienenMismosIngredientes(recetaNueva, recetaPrevia) || 
                self.dificultadSimilar(recetaNueva, recetaPrevia)
        }

        method tienenMismosIngredientes(r1, r2) {
            return r1.ingredientes() == r2.ingredientes()
        }

        method dificultadSimilar(r1, r2) {
            return (r1.nivelPreparacion() - r2.nivelPreparacion()).abs() <= 1
        }

        override method superoNivel(unCocinero){
            return unCocinero.comidasDificiles() >= 5
        }
}


class Chef inherits NivelAprendizaje{
    override method puedePreparar(unaReceta, unCocinero) {
        return true
    }

    override method superoNivel(unCocinero){
        return false
    }
}


class Comida{
    const property receta
    const property experiencia = 0

    method experienciaQueAporta() {
        return receta.experienciaBase()
    }

}

class ComidaSuperior inherits Comida{
    var experienciaMaxima = 0
    var plus = 0

    override method experienciaQueAporta(){
        return super() + plus
    }
}

class ComidaPobre inherits Comida{
    override method experienciaQueAporta(){
        return super().min(configuracionAcademia.topeExperienciaPobre())
    }
}

object configuracionAcademia {
    var property topeExperienciaPobre = 4 
}

