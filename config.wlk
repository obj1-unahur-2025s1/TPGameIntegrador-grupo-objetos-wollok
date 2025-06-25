import jugador.*
import mundo.*
object config {
  method configurarTeclas() {
    keyboard.left().onPressDo({if (mundo.juegoActivo()) personaje.irEn(izquierda) })
    keyboard.right().onPressDo({if (mundo.juegoActivo()) personaje.irEn(derecha) })
    keyboard.up().onPressDo({if (mundo.juegoActivo()) personaje.irEn(arriba) })
    keyboard.down().onPressDo({if (mundo.juegoActivo()) personaje.irEn(abajo) })
    
    keyboard.r().onPressDo({personaje.perderVida()})
  }
}


object romperTierra{
  method play(){
    game.sound("tierraRompiendose.mp3").play()
  }
}

object explosion{
  method play(){
    game.sound("explosion.mp3").play()
  }
}

object seQuemo {
  method play() {
    game.sound("quemado.mp3").play()
  }
}