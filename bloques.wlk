import jugador.*
import mundo.*
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
        const hayOtraPiedraDebajo = objetosAbajo.any({o => o.kindName() == "a Piedra" or o.kindName() == "a Ladrillo"})

        if (hayOtraPiedraDebajo) {
          const izquierdaLado = position.left(1)
          const izquierdaAbajo = izquierdaLado.down(1)
          const derechaLado = position.right(1)
          const derechaAbajo = derechaLado.down(1)

          const puedeResbalarIzq = izquierdaAbajo.y() < 14 and 
                                  game.getObjectsIn(izquierdaLado).isEmpty() and 
                                  game.getObjectsIn(izquierdaAbajo).isEmpty()

          const puedeResbalarDer = derechaAbajo.y() < 14 and 
                                  game.getObjectsIn(derechaLado).isEmpty() and 
                                  game.getObjectsIn(derechaAbajo).isEmpty()

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
}
                               
class Ladrillo {
  var property position
  method position() = position
  method image() = "ladrilloPrueba.png"
}

class Diamante {
  var property position
  var enCaida = false

  method position() = position
  method image() = "diamantePrueba.png"

  method caerSiPuede() {
    const abajo = position.down(1)
    const objetosAbajo = game.getObjectsIn(abajo)

    if (abajo.y() < 14) {
      if (objetosAbajo.isEmpty()) {
        position = abajo
        enCaida = true
      } else {
        enCaida = false

        const hayOtroDiamanteDebajo = objetosAbajo.any({o => o.kindName() == "a Diamante"})

        if (hayOtroDiamanteDebajo) {
          const izquierdaLado = position.left(1)
          const izquierdaAbajo = izquierdaLado.down(1)
          const derechaLado = position.right(1)
          const derechaAbajo = derechaLado.down(1)

          const puedeResbalarIzq = izquierdaAbajo.y() < 14 and 
                                  game.getObjectsIn(izquierdaLado).isEmpty() and 
                                  game.getObjectsIn(izquierdaAbajo).isEmpty()

          const puedeResbalarDer = derechaAbajo.y() < 14 and 
                                  game.getObjectsIn(derechaLado).isEmpty() and 
                                  game.getObjectsIn(derechaAbajo).isEmpty()

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
}

class Puerta {
  var property position
  method position() = position
  method image() = "puertaPrueba.png"
}

