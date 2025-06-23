import texto.*
import niveles.*
import bloques.*
import mundo.*
object personaje {
  var property position = game.at(0, 0)
  var direccion = derecha  // por defecto
  method image() = "jugador.png"
  

  method irEn(unaDireccion) {
    direccion = unaDireccion
    const nuevaPosicion = direccion.siguiente(position)
    const objetos = game.getObjectsIn(nuevaPosicion)

    if (objetos.any({o => o.kindName() == "a Piedra"})) {
      const piedra = objetos.find({o => o.kindName() == "a Piedra"})

      if (direccion.esIzquierda() or direccion.esDerecha()) {
        const posPiedraDestino = direccion.siguiente(piedra.position())

      if (posPiedraDestino.y() < 14 and game.getObjectsIn(posPiedraDestino).isEmpty()) {
        piedra.position(posPiedraDestino)
        position = nuevaPosicion 
      } 
  }} 
    else if (self.esPosicionValida(nuevaPosicion)) {
      position = nuevaPosicion
      self.eliminarTierraEn(nuevaPosicion)
      self.recolectarSiHayDiamanteEn(nuevaPosicion)
      self.pasarPorPuertaSiCorresponde(nuevaPosicion)
  }
}

  method eliminarTierraEn(pos) {
    game.getObjectsIn(pos).filter({o => o.kindName() == "a Tierra"}).forEach({t => game.removeVisual(t)})
  }

  method esPosicionValida(pos) {
    return pos.x() >= 0 and pos.x() < 30 and pos.y() >= 0 and pos.y() < 14 and 
      game.getObjectsIn(pos).all({o => 
        o.kindName() == "a Tierra" or o.kindName() == "a Diamante" or o.kindName() == "a Puerta"
      })
  }

  method recolectarSiHayDiamanteEn(pos) {
    game.getObjectsIn(pos).filter({o => o.kindName() == "a Diamante"}).forEach({d =>
      game.removeVisual(d)
      mundo.recolectarDiamante()
    })
  }

  method pasarPorPuertaSiCorresponde(pos) {
  if (mundo.puertaAbierta() and game.getObjectsIn(pos).any({o => o.kindName() == "a Puerta"} )) {
    mundo.pasarDeNivel() 
    }
  }
}


// Posiciones.
object izquierda {
  method siguiente(pos) = pos.left(1)

  method esIzquierda() = true
  method esDerecha() = false
}

object derecha {
  method siguiente(pos) = pos.right(1)

  method esIzquierda() = false
  method esDerecha() = true
}

object arriba {
  method siguiente(pos) = pos.up(1)

  method esIzquierda() = false
  method esDerecha() = false
}

object abajo {
  method siguiente(pos) = pos.down(1)

  method esIzquierda() = false
  method esDerecha() = false
}

