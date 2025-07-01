import jugador.*
import mundo.*
import texto.*
import config.*
class Bloque{
  var property position

  method esControlado() = false

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
  method afectarAlPersonaje(){}
  method agregarAGravedadSiCorresponde(){}

}

class BloqueCaible inherits Bloque{
  var enCaida = false

  method puedeCaerEn(pos) = pos.y() < game.height()
  method caerSiPuede() {
    const abajo = position.down(1)
    const objetosAbajo = game.getObjectsIn(abajo)

    if (self.puedeCaerEn(abajo)) {
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

    if (self.puedeResbalarALaIzquierda(izquierdaLado, izquierdaAbajo))
      position = izquierdaAbajo
    else if (self.puedeResbalarALaDerecha(derechaLado,derechaAbajo) )
      position = derechaAbajo

    enCaida = true
  }

  method puedeResbalarALaIzquierda(lado, abajo) = self.puedeCaerEn(abajo) and game.getObjectsIn(lado).isEmpty() and game.getObjectsIn(abajo).isEmpty() and not game.getObjectsIn(abajo).any({o => o.esControlado()})

  method puedeResbalarALaDerecha(lado, abajo) = self.puedeCaerEn(abajo) and   game.getObjectsIn(lado).isEmpty() and   game.getObjectsIn(abajo).isEmpty() and   not game.getObjectsIn(abajo).any({o => o.esControlado()})

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
    override method afectarAlPersonaje() {
      seQuemo.play()
      personaje.desaparecer()
      mundo.congelarJuego()
      self.desaparecer()
  }
}


class Puerta inherits Bloque {
  method image() = "puerta.png"

  override method permitePasar() = true
  override method esEntrable() = true
}

class Bomba inherits Bloque {

  method image() = "bomba1.gif"
  override method permitePasar() = true

  override method afectarAlPersonaje() {
    explosion.play()
    mundo.explotarEn(personaje.position())
    self.desaparecer()
    personaje.desaparecer()
    mundo.congelarJuego()
  }
}


class Diamante inherits BloqueCaible{
  method image() = "diamante.png"

  override method permitePasar() = true

  override method debeResbalar(objetosAbajo) = objetosAbajo.any({o => o.resbala()}) 
  override method recolectarSiCorresponde(){
    self.desaparecer()
    mundo.recolectarDiamante()
  }

  
}

class Piedra inherits BloqueCaible {
  method image() = "piedra.png"

  override method debeResbalar(objetosAbajo) = objetosAbajo.any({o => o.resbala()})
  override method resbala() = true
  override method puedeSerEmpujado() = true

  method intentarMover(dir) {
    const destino = dir.siguiente(position)
    if (self.puedeCaerEn(destino) and game.getObjectsIn(destino).isEmpty()) {
      position = destino
    }
  }

  

  override method caerSiPuede() {
    const abajo = position.down(1)
    const objetosAbajo = game.getObjectsIn(abajo)

    if (self.puedeCaerEn(abajo)) {
      if (objetosAbajo.isEmpty()) {
        position = abajo
        enCaida = true
      } else if (objetosAbajo.any({o => o.esControlado()})) {
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

  
}


                               