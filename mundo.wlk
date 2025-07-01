import config.*
import niveles.*
import texto.*
import bloques.*
import jugador.*

object progreso{
  var property diamantesRecolectados = 0
  var property diamantesRequeridos = 0

  method agregarDiamante(){
    diamantesRecolectados += 1
    game.removeVisual(textoDiamantes)
    game.addVisual(textoDiamantes) //Actualiza el texto de diamantes
  }

  method nivelCompletado() = diamantesRecolectados >= diamantesRequeridos
}

object administradorDeNivel{
  var property nivelActual = nivel1

  method iniciarJuego(){
    if (nivelActual == null) {
      nivelActual = nivel1
    }
    self.prepararNivelActual()
  }

  method pasarDeNivel(){
    const siguiente = nivelActual.nivelSiguiente()
    if (siguiente != null) {
      nivelActual = siguiente
      self.prepararNivelActual()
    } else {
      game.clear()
      game.addVisual(textoFinal)
      mundo.congelarJuego()
    }
  }

  method reiniciarNivel(){
    self.prepararNivelActual()
  }

  method prepararNivelActual(){
    game.clear()
    self.reiniciarEstadoDelNivel(nivelActual.diamantesRequeridos())

    nivelActual.iniciar()
    config.configurarTeclas()

    game.onTick(300, "gravedadPiedras",{
      mundo.aplicarGravedad()
    })

    game.onTick(200, "animacionActual",{
      personaje.actualizarEstado()
    })

    game.addVisual(textoDiamantes)
    game.addVisual(textoVidas)
    game.addVisual(textoReinicio)
  }

  method reiniciarEstadoDelNivel(cantidadDeDiamantes) {
    mundo.diamantes().clear()
    mundo.piedras().clear()
    mundo.diamantesTotales(0)
    progreso.diamantesRecolectados(0)
    progreso.diamantesRequeridos(cantidadDeDiamantes)
    mundo.puertaAbierta(false)
    mundo.activarJuego()
  }

  
}

object mundo {
  const property piedras = []
  const property diamantes = []
  var property diamantesTotales = 0
  
  var property puertaAbierta = false

  
  var juegoActivo = true

  method juegoActivo() = juegoActivo 
  method activarJuego(){
    juegoActivo = true
  }

  method iniciarJuego() {
  administradorDeNivel.iniciarJuego()
}

  method reiniciarNivel() {
    administradorDeNivel.reiniciarNivel()
  }

  method pasarDeNivel() {
    administradorDeNivel.pasarDeNivel()
  }



  method agregarDiamante(diamante) {
    diamantes.add(diamante)
    diamantesTotales += 1
  }

  method recolectarDiamante() {
    progreso.agregarDiamante()
  

  if (progreso.nivelCompletado() and not puertaAbierta) {
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
        .filter({o => o.esDestructible()})
        .forEach({t => t.desaparecer()})
    })
}

  

  method finDelJuego(){
    game.clear()
    game.addVisual(textoGameOver)
  }
  
  
  method congelarJuego(){
    juegoActivo = false
  }
    
}
