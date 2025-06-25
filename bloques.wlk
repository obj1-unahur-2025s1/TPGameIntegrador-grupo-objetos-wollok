import jugador.*
import mundo.*
import texto.*
class Bloque{
  var property position

  method esPersonaje() = false
}

class BloqueCaible inherits Bloque{
  var enCaida = false

  method caerSiPuede() {
    const abajo = position.down(1)
    const objetosAbajo = game.getObjectsIn(abajo)

    if (abajo.y() < 14) {
      if (objetosAbajo.isEmpty()) {
        position = abajo
        enCaida = true
      } else {
        enCaida = false
        if (self.debeResbalar(objetosAbajo)) self.intentarResbalar()
      }
    }
  }
  

  method debeResbalar(objetosAbajo) = false

  method intentarResbalar() {
    const izquierdaLado = position.left(1)
    const izquierdaAbajo = izquierdaLado.down(1)
    const derechaLado = position.right(1)
    const derechaAbajo = derechaLado.down(1)

    const puedeResbalarIzq = izquierdaAbajo.y() < 14 and game.getObjectsIn(izquierdaLado).isEmpty() and game.getObjectsIn(izquierdaAbajo).isEmpty()

    const puedeResbalarDer = derechaAbajo.y() < 14 and game.getObjectsIn(derechaLado).isEmpty() and game.getObjectsIn(derechaAbajo).isEmpty()

    if (puedeResbalarIzq and !game.getObjectsIn(izquierdaAbajo).any({o => o.esPersonaje()}))
      position = izquierdaAbajo
    else if (puedeResbalarDer and !game.getObjectsIn(derechaAbajo).any({o => o.esPersonaje()}))
      position = derechaAbajo

    enCaida = true
  }
}


class Tierra inherits Bloque {
  
  method image() = "dirt.png"
}

class Ladrillo inherits Bloque{
  method image() = "ladrillo.png"
}


class Puerta inherits Bloque {
  method image() = "puerta.png"
}

class Bomba inherits Bloque {

  method image() = "bomba1.gif"
}


class Diamante inherits BloqueCaible{
  method image() = "diamante.png"

  override method debeResbalar(objetosAbajo) = objetosAbajo.any({o => o.kindName() == "a Diamante"}) 
}

class Piedra inherits BloqueCaible {
  method image() = "piedra.png"

  override method debeResbalar(objetosAbajo) = objetosAbajo.any({o => o.kindName() == "a Piedra" or o.kindName() == "a Ladrillo"})
  

  method intentarMover(dir) {
    const destino = dir.siguiente(position)
    if (destino.y() < 14 and game.getObjectsIn(destino).isEmpty()) {
      position = destino
    }
  }

  override method caerSiPuede() {
    const abajo = position.down(1)
    const objetosAbajo = game.getObjectsIn(abajo)

    if (abajo.y() < 14) {
      if (objetosAbajo.isEmpty()) {
        position = abajo
        enCaida = true
      } else if (objetosAbajo.any({o => o.esPersonaje()})) {
        if (enCaida) {
          mundo.explotarEn(abajo)
          game.removeVisual(personaje)
          mundo.congelarJuego()
          
        }
        enCaida = false
      } else {
        enCaida = false
        if (self.debeResbalar(objetosAbajo)) self.intentarResbalar()
      }
    }
  }
}


                               