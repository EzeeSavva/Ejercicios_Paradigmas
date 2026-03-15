class Juego {
    const property precioBase 
    var property descuento = sinDescuento 

    method precioFinal() {
        return descuento.precioConDescuento(precioBase)
    }

    method superaJuegoMasCaro(unPorcentaje){
        if(descuento == DescuentoDirecto){
            self.precioFinal()
        }
    }
}


object sinDescuento {
    method precioConDescuento(precio) = precio
}

class DescuentoDirecto {
    var property porcentaje 
    method precioConDescuento(precio) = precio * (1 - porcentaje / 100)
}

class DescuentoFijo {
    var property monto
    method precioConDescuento(precio) {
        return (precio - monto).max(precio / 2)
    }
}

object gratis {
    method precioConDescuento(precio) = 0
}

object estim {
    const juegos = []

    method aplicarDescuentoEspecial(porcentaje) {
        const limite = self.precioDelMasCaro() * 0.75
        
        juegos.filter({ j => j.precioFinal() > limite }).forEach({ j => j.descuento(new DescuentoDirecto(porcentaje = porcentaje)) })
    }

    method precioDelMasCaro() {
        if (juegos.isEmpty()) return 0
        return juegos.map({ j => j.precioFinal() }).max()
    }
}