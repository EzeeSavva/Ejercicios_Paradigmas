class Archivo{
    var property nombre = ""
    var property contenido = ""
    var property carpeta = ""


    method agregarTexto(textoIndicado){
        contenido = contenido + textoIndicado
    }

    method sacarTexto(textoIndicado){
        contenido = contenido - textoIndicado
    }
}

class Usuario{

}

class Carpeta{
    var property archivos = []

    method estaElArchivo(nombreArchivo){
        return self.archivos().any({archivo => archivo.nombre() == nombreArchivo})
    }

    method añadirArchivo(nombreArchivo){
        archivos.add(new Archivo(nombre = nombreArchivo, contenido = null, carpeta = self))
    }

    method removerArchivo(nombreArchivo){
        archivos.remove(nombreArchivo)
    }

    method agregar(nombreArchivo, textoIndicado){
        nombreArchivo.agregarTexto(textoIndicado)
    }

    method sacar(nombreArchivo, textoIndicado){
        nombreArchivo.sacarTexto(textoIndicado)
    }

}
class Commit {
    var property descripcion
    var property cambios = [] 

    method ejecutar(carpeta) {
        cambios.forEach({ cambio => cambio.realizar(carpeta) })
    }

    method afectaA(unArchivo){
        return self.cambios().any({cambio => cambio.nombreArchivo() == unArchivo})
}
}


class Cambio {
    var property nombreArchivo
    var property textoIndicado = ""


    method realizar(carpeta)

    method validarExistencia(carpeta) {
        if (!carpeta.estaElArchivo(nombreArchivo)) {
            self.error("El archivo no existe en la carpeta")
        }
    }
}

class Crear inherits Cambio {
    override method realizar(carpeta) {
        if (carpeta.estaElArchivo(nombreArchivo)) {
            self.error("Ya existe un archivo con ese nombre")
        }
        carpeta.añadirArchivo(nombreArchivo)
    }
}

class Eliminar inherits Cambio {
    override method realizar(carpeta) {
        self.validarExistencia(carpeta)
        carpeta.removerArchivo(nombreArchivo)
    }
}

class Agregar inherits Cambio{
    override method realizar(carpeta){
        self.validarExistencia(carpeta)
        carpeta.agregar(nombreArchivo, textoIndicado)
    }
}

class Sacar inherits Cambio{
    override method realizar(carpeta){
        self.validarExistencia(carpeta)
        carpeta.sacar(nombreArchivo, textoIndicado)
    }

}

class Branch{
    var property commits = []
    method checkout(unaCarpeta){
        commits.forEach({commit => commit.ejecutar(unaCarpeta)})
    }

    method conocerLog(unArchivo){
        return commits.filter({commit => commit.afectaA(unArchivo)})
    }
}

