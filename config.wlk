import jugador.*
object config {
  method configurarTeclas() {
    keyboard.left().onPressDo({ personaje.irEn(izquierda) })
    keyboard.right().onPressDo({ personaje.irEn(derecha) })
    keyboard.up().onPressDo({ personaje.irEn(arriba) })
    keyboard.down().onPressDo({ personaje.irEn(abajo) })
  }
}
