import texto.*
import niveles.*
import bloques.*
import mundo.*
import config.*

object personaje {
  var property position = game.at(0, 0)
  var direccion = derecha  // por defecto
  var vidas = 3
  var property estaEnMovimiento = false
  var property image = "personajeIdleDef.gif"
  
  method actualizarEstado() {
    estaEnMovimiento = false
    self.actualizarImagen()
  }

  method actualizarImagen(){
     if(self.estaEnMovimiento()){
      image = "personajeRunDef.gif"
     }
     else {
      image = "personajeIdleDef.gif"
     }
  }
  
  method vidas() = vidas

  method irEn(unaDireccion) {
    direccion = unaDireccion
    const nuevaPosicion = direccion.siguiente(position)
    const objetos = game.getObjectsIn(nuevaPosicion)
    var huboMovimiento = false 

    if (objetos.any({o => o.puedeSerEmpujado()})) {
      const piedra = objetos.find({o => o.puedeSerEmpujado()})

      if (direccion.esIzquierda() or direccion.esDerecha()) {
        const posPiedraDestino = direccion.siguiente(piedra.position())
        

      if (posPiedraDestino.y() < 14 and game.getObjectsIn(posPiedraDestino).isEmpty()) {
        piedra.position(posPiedraDestino)
        position = nuevaPosicion 
        huboMovimiento = true
      } 
  }} 
    else if (self.esPosicionValida(nuevaPosicion)) {
      position = nuevaPosicion
      self.eliminarTierraEn(nuevaPosicion)
      self.recolectarSiHayDiamanteEn(nuevaPosicion)
      self.pasarPorPuertaSiCorresponde(nuevaPosicion)
      huboMovimiento = true
  }
    // cambia la animacion al moverse
     estaEnMovimiento = huboMovimiento
     self.actualizarImagen()
}

  method eliminarTierraEn(pos) {
    if(game.getObjectsIn(pos).any({o => o.esDestructible()})){
      game.getObjectsIn(pos).filter({o => o.esDestructible()}).forEach({t => game.removeVisual(t)})
      romperTierra.play()
    }
    
  }

  method esPosicionValida(pos) {
    return pos.x() >= 0 and pos.x() < 30 and pos.y() >= 0 and pos.y() < 14 and 
      game.getObjectsIn(pos).all({o => 
        o.permitePasar()
      })
  }

  method recolectarSiHayDiamanteEn(pos) {
    game.getObjectsIn(pos).forEach({o => o.recolectarSiCorresponde()})
  }

  method pasarPorPuertaSiCorresponde(pos) {
  if (mundo.puertaAbierta() and game.getObjectsIn(pos).any({o => o.esEntrable()} )) {
    mundo.pasarDeNivel() 
    }
  }

  method esPersonaje() = true

  method perderVida() {
    vidas -= 1
    
    game.removeVisual(textoVidas)
    game.addVisual(textoVidas)
    
    if (vidas == 0) {
      mundo.finDelJuego()
    } else {
    mundo.reiniciarNivel()
    }
  }
  method esDestructible() = false
  method permitePasar() = false
  method recolectarSiCorresponde() = false
  method puedeSerEmpujado() = false
  method esEntrable() = false
  method resbala() = false

  method desaparecer(){
    game.removeVisual(self)
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

