class Casa{
    var property familia = []
    var property patrimonio = 0
    var property nombreCiudad = "asd"

    method permiteMatrimonio(personaje, pretendiente)

    method esRica() = patrimonio > 1000

}

class Personaje{
    var property pareja = []
    var property casa = Casa
    var property acompañantes = []
    var property vive = true
    var property personalidad = Sutiles

    method patrimonioPersonaje() = if (casa != null) casa.patrimonio() / 5 else 0

    method esSoltero() = pareja.isEmpty()

    method nuevaPareja(nuevaPareja){
        pareja.add(nuevaPareja) 
    }

    method seCasaCon(pretendiente){
        if(not casa.permiteMatrimonio(self, pretendiente)){
            self.error("No se puede casar")
        }
        self.nuevaPareja(pretendiente)
        pretendiente.nuevaPareja(self)
    }

    method estaSolo(){
        return acompañantes.isEmpty()
    }

    method aliados(){
        return (self.acompañantes() + self.pareja() + casa.familia()).asSet()
    }

    method aliadosSuman10k(){
        return self.aliados().sum({persona => persona.patrimonioPersonaje()}) > 10000

    }
    method todosConyuguesRicos(){
        return self.pareja().all({pareja => pareja.casa().esRica()})
    }

    method aliadoPeligroso() {
        return self.aliados().any({persona => persona.esPeligroso()})
    }

    method esPeligroso() = self.vive() && (self.aliadosSuman10k() || self.todosConyuguesRicos()) && self.aliadoPeligroso() 

    method participarEnConspiracion(conspiracion) {
        personalidad.realizarAccion(conspiracion.objetivo(), self)
    }
}

class Lanisster inherits Casa{
    var property familiaLannister = []
    override method permiteMatrimonio(personaje, pretendiente) {
        return personaje.esSoltero()
    }
}

class Stark inherits Casa {
    override method permiteMatrimonio(personaje, pretendiente) {
        return personaje.casa() != pretendiente.casa()
    }
}

class GuardiaDeLaNoche inherits Casa {
    override method permiteMatrimonio(personaje, pretendiente) = false
}

object dragon{
    method esPeligroso() = true
}

object lobos{
    var property huargos = false
    method esPeligroso() = self.huargos()

}

class Conspiracion{
    var property personaObjetivo = Personaje

    method conspirarContra(unaPersona)

}

class Sutiles{
method realizarAccion(objetivo, complotado) {
        const candidato = self.buscarCandidatoPobre()
        
        // 2. Intentar casarlos (esto ya tiene la lógica de falla si no se puede)
        objetivo.casarseCon(candidato)
    }

    method buscarCandidatoPobre() {
        if()
        // Aquí deberías tener una lista de todas las casas o personajes 
        // y encontrar al soltero de la casa con menos patrimonio.
        // Si no hay nadie, debería lanzar un error: 
        
        return self.error("No hay nadie pobre soltero")
    }
}

