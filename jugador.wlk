object personaje {
  var property position = game.at(0, 0)
  var direccion = derecha  // por defecto
  method image() = "jugador idle.png"
  

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
  var enCaida = false

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
    const objetosAbajo = game.getObjectsIn(abajo)

    if (abajo.y() < 14) {
      if (objetosAbajo.isEmpty()) {
        position = abajo
        enCaida = true
      } else if (objetosAbajo.any({o => o == personaje})) {
        if (enCaida) {
          mundo.explotarEn(abajo)
          game.removeVisual(personaje)
        }
        // Si hay jugador justo debajo y no estaba cayendo, entonces se queda quieta
        enCaida = false
      } else {
        // Si encuentra algo solido (piedra, ladrillo, tierra): considera resbalamiento
        enCaida = false

        const izquierdaLado = position.left(1)
        const izquierdaAbajo = izquierdaLado.down(1)
        const derechaLado = position.right(1)
        const derechaAbajo = derechaLado.down(1)

        const puedeResbalarIzq = izquierdaAbajo.y() < 14 and game.getObjectsIn(izquierdaLado).isEmpty() and game.getObjectsIn(izquierdaAbajo).isEmpty()

        const puedeResbalarDer = derechaAbajo.y() < 14 and game.getObjectsIn(derechaLado).isEmpty() and game.getObjectsIn(derechaAbajo).isEmpty()

        if (puedeResbalarIzq and !game.getObjectsIn(izquierdaAbajo).any({o => o == personaje})) {
          position = izquierdaAbajo
          enCaida = true
        } else if (puedeResbalarDer and !game.getObjectsIn(derechaAbajo).any({o => o == personaje})) {
          position = derechaAbajo
          enCaida = true
        }
    }
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

  method explotarEn(pos) {
    const x0 = pos.x()
    const y0 = pos.y()

    [-1, 0, 1].forEach({dx =>
      [-1, 0, 1].forEach({dy =>
        const posAEliminar = game.at(x0 + dx, y0 + dy)
        game.getObjectsIn(posAEliminar)
          .filter({o => o.kindName() == "a Tierra"})
          .forEach({t => game.removeVisual(t)})
      })
    })
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