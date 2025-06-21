object personaje {
  var position = game.at(0, 0)
  var direccion = derecha  // por defecto
  method image() = "personajePrueba.png"
  method position() = position

  method irEn(unaDireccion) {
    direccion = unaDireccion
    const nuevaPosicion = direccion.siguiente(position)
    const objetos = game.getObjectsIn(nuevaPosicion)

    if (objetos.any({o => o.kindName() == "a Piedra"})) {
      const piedra = objetos.find({o => o.kindName() == "a Piedra"})

      if (direccion == izquierda or direccion == derecha) {
        const posPiedraDestino = direccion.siguiente(piedra.position())

      if (posPiedraDestino.y() < 14 and game.getObjectsIn(posPiedraDestino).isEmpty()) {
        piedra.position(posPiedraDestino)
        position = nuevaPosicion 
      } 
  }} 
    else if (self.esPosicionValida(nuevaPosicion)) {
    position = nuevaPosicion
    self.eliminarTierraEn(nuevaPosicion)
  }
}

  method eliminarTierraEn(pos) {
    game.getObjectsIn(pos).filter({o => o.kindName() == "a Tierra"}).forEach({t => game.removeVisual(t)})
  }

  method esPosicionValida(pos) {
  return pos.x() >= 0 and pos.x() < 30 and pos.y() >= 0 and pos.y() < 14 and 
    game.getObjectsIn(pos).all({o => o.kindName() == "a Tierra"})
}
}

class Tierra {
  var property position

  method position() = position
  method image() = "tierraPrueba.png"
}

class Piedra {
  var property position
  method position() = position
  method image() = "piedraPrueba.png"

  method intentarMover(dir) {
    const destino = dir.siguiente(position)
    if (destino.y() < 14 and game.getObjectsIn(destino).isEmpty()) {
      position = destino
    }
  }

  method caerSiPuede() {
    const abajo = position.down(1)
    if (abajo.y() < 14 and game.getObjectsIn(abajo).isEmpty()) {
      position = abajo
    }
  }
}

class Ladrillo {
  var property position
  method position() = position
  method image() = "ladrillo.png"
}

object mundo {
  const property piedras = []

  method agregarPiedra(piedra) {
    piedras.add(piedra)
  }

  method aplicarGravedad() {
    piedras.forEach({p => p.caerSiPuede()})
  }
}

object config {
  method configurarTeclas() {
    keyboard.left().onPressDo({ personaje.irEn(izquierda) })
    keyboard.right().onPressDo({ personaje.irEn(derecha) })
    keyboard.up().onPressDo({ personaje.irEn(arriba) })
    keyboard.down().onPressDo({ personaje.irEn(abajo) })
  }
}

object izquierda {
  method siguiente(pos) = pos.left(1)
}

object derecha {
  method siguiente(pos) = pos.right(1)
}

object arriba {
  method siguiente(pos) = pos.up(1)
}

object abajo {
  method siguiente(pos) = pos.down(1)
}