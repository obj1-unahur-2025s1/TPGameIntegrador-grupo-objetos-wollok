import jugador.*
import mundo.*
object config {
  method configurarTeclas() {
    keyboard.left().onPressDo({ personaje.irEn(izquierda) })
    keyboard.right().onPressDo({ personaje.irEn(derecha) })
    keyboard.up().onPressDo({ personaje.irEn(arriba) })
    keyboard.down().onPressDo({ personaje.irEn(abajo) })

    keyboard.r().onPressDo({personaje.perderVida()})
    keyboard.enter().onPressDo({explosion.play()})

  }
}

object explosion {

  method play(){
    game.sound("explosion.mp3").play()
  }
}

object romperTierra{
  method play(){
    game.sound("tierraRompiendose.mp3").play()
  }
}