import config.*
import niveles.*
import texto.*
import bloques.*
import jugador.*

object mundo {
  const property piedras = []
  const property diamantes = []
  var property diamantesTotales = 0
  var property diamantesRecolectados = 0
  var property diamantesRequeridos = 0
  var property puertaAbierta = false

  var property nivelActual = nivel1
  var juegoActivo = true

  method juegoActivo() = juegoActivo 

  method reiniciarContador(cantidadDeDiamantes){
    diamantes.clear()
    piedras.clear()
    diamantesTotales = 0    
    diamantesRecolectados = 0
    puertaAbierta = false
    diamantesRequeridos = cantidadDeDiamantes
  }


  method agregarDiamante(diamante) {
    diamantes.add(diamante)
    diamantesTotales += 1
  }

  method recolectarDiamante() {
  diamantesRecolectados += 1
  game.removeVisual(textoDiamantes)
  game.addVisual(textoDiamantes)

  if (diamantesRecolectados >= diamantesRequeridos and not puertaAbierta) {
    puertaAbierta = true
    const puerta = new Puerta(position = g.posicion())
    game.addVisual(puerta)

  }}

  method agregarPiedra(piedra) {
    piedras.add(piedra)
  }

  method aplicarGravedad() {
    piedras.forEach({p => p.caerSiPuede()})
    diamantes.forEach({d => d.caerSiPuede()})
  }

  method explotarEn(pos) {
    const x = pos.x()
    const y = pos.y()

    const posiciones = [
        game.at(x - 1, y - 1), game.at(x, y - 1), game.at(x + 1, y - 1),
        game.at(x - 1, y),     game.at(x, y),     game.at(x + 1, y),
        game.at(x - 1, y + 1), game.at(x, y + 1), game.at(x + 1, y + 1)
    ]
    
    posiciones.forEach({posAEliminar =>
        game.getObjectsIn(posAEliminar)
        .filter({o => o.kindName() == "a Tierra"})
        .forEach({t => game.removeVisual(t)})
    })
}

  method iniciarJuego() {
    game.clear()
    self.nivelActual(nivel1)
    self.nivelActual().iniciar()
    config.configurarTeclas()
    game.onTick(300, "gravedadPiedras", {
      self.aplicarGravedad()
    })
    game.onTick(200, "animacionActual", {
      personaje.actualizarEstado()
    })
    game.addVisual(textoDiamantes)
    game.addVisual(textoVidas)
    game.addVisual(textoReinicio)
}

  method pasarDeNivel() {
    const siguiente = self.nivelActual().nivelSiguiente()
    if (siguiente != null) {
      game.clear()
      nivelActual = siguiente
      siguiente.iniciar()
      config.configurarTeclas()
      game.onTick(300, "gravedadPiedras", {
        self.aplicarGravedad()
      })
      }

    game.addVisual(textoDiamantes)
    game.addVisual(textoVidas)
  }

  method finDelJuego(){
    game.clear()
    game.addVisual(textoGameOver)
  }
  
  method reiniciarNivel() {
    juegoActivo = true
    game.clear()
    self.nivelActual().iniciar()
    config.configurarTeclas()
    game.onTick(300, "gravedadPiedras", {
      self.aplicarGravedad()
    })

    game.addVisual(textoDiamantes)
    game.addVisual(textoVidas)
    game.addVisual(textoReinicio)
  }

  method congelarJuego(){
    juegoActivo = false
  }
    
}
