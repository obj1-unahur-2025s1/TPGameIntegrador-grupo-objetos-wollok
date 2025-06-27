import jugador.*
import mundo.*
import texto.*
class Bloque{
  var property position

  method esPersonaje() = false

  //interaccion
  method permitePasar() = false
  method esDestructible() = false
  method puedeSerEmpujado() = false
  method recolectarSiCorresponde(){}
  method esEntrable() = false
  method resbala() = false

  method desaparecer(){
    game.removeVisual(self)
  }

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

  override method permitePasar() = true
  override method esDestructible() = true
}

class Ladrillo inherits Bloque{
  method image() = "ladrillo.png"

  override method resbala() = true

}

class Lava inherits Bloque {
    method image() = "lava.gif"

    override method permitePasar() = true
}


class Puerta inherits Bloque {
  method image() = "puerta.png"

  override method permitePasar() = true
  override method esEntrable() = true
}

class Bomba inherits Bloque {

  method image() = "bomba1.gif"
  override method permitePasar() = true
}


class Diamante inherits BloqueCaible{
  method image() = "diamante.png"

  override method permitePasar() = true

  override method debeResbalar(objetosAbajo) = objetosAbajo.any({o => o.kindName() == "a Diamante"}) 
  override method recolectarSiCorresponde(){
    self.desaparecer()
    mundo.recolectarDiamante()
  }
}

class Piedra inherits BloqueCaible {
  method image() = "piedra.png"

  override method debeResbalar(objetosAbajo) = objetosAbajo.any({o => o.resbala()})
  override method resbala() = true

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
          personaje.desaparecer()
          mundo.congelarJuego()
          
        }
        enCaida = false
      } else {
        enCaida = false
        if (self.debeResbalar(objetosAbajo)) self.intentarResbalar()
      }
    }
  }

  override method puedeSerEmpujado() = true
}


                               