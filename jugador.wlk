object personaje {
  var position = game.at(0, 0) // pos inicial 
  method image() = "personajePrueba.png"
  method position() = position

  method irA(nuevaPosicion) {
    if (self.esPosicionValida(nuevaPosicion)) {
      position = nuevaPosicion
      self.eliminarTierraEn(nuevaPosicion)
    }
  }

  method esPosicionValida(unaPosicion) {
    return unaPosicion.x() >= 0 and unaPosicion.x() < 30 and unaPosicion.y() >= 0 and unaPosicion.y() < 14
  }

  method eliminarTierraEn(unaPosicion) {
    const tierras = game.getObjectsIn(unaPosicion).filter({obj => obj.kindName() == "a Tierra"})
    tierras.forEach({t => game.removeVisual(t)})
  }
}

class Tierra {
  var property position

  method position() = position
  method image() = "tierraPrueba.png"
}

object config {
  method configurarTeclas() {
    keyboard.left().onPressDo({ personaje.irA(personaje.position().left(1)) })
    keyboard.right().onPressDo({ personaje.irA(personaje.position().right(1)) })
    keyboard.up().onPressDo({ personaje.irA(personaje.position().up(1)) })
    keyboard.down().onPressDo({ personaje.irA(personaje.position().down(1)) })
  }
}

