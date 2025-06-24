import jugador.*
import mundo.*
object textoDiamantes {
  method position() = game.at(1, 13)
  method text() = "Diamantes: " + mundo.diamantesRecolectados().toString() + "/" + mundo.diamantesTotales().toString()
  method textColor() = "00FFFF"
}

object textoVidas {
  method position() = game.at(24, 13)
  method text() = "Vidas: " + personaje.vidas().toString()
  method textColor() = "FFAA00"
}

object textoGameOver {
  method position() = game.at(13, 7)
  method text() = "¡Game Over!"
  method textColor() = "FF0000"
  method fontSize() = 24
}


object textoFinal {
  method position() = game.at(5, 7)
  method text() = "¡Felicidades! Juego completado."
  method textColor() = "00FF00"
  method fontSize() = 24
}
