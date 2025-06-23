import config.*
import niveles.*
import texto.*
import bloques.*
object mundo {
  const property piedras = []
  const property diamantes = []
  var property diamantesTotales = 0
  var property diamantesRecolectados = 0
  var property diamantesRequeridos = 0
  var property puertaAbierta = false
  //var property siguienteNivel = null
  var property nivelActual = nivel1

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

  method pasarDeNivel() {
    const siguiente = self.nivelActual().nivelSiguiente()
    if (siguiente != null) {
      game.clear()
      nivelActual = siguiente
      siguiente.iniciar()
      config.configurarTeclas()
      game.onTick(500, "gravedadPiedras", {
        self.aplicarGravedad()
      })
      }
    }
}
