import jugador.*
object textoDiamantes {
  method position() = game.at(1, 13)
  method text() = "Diamantes: " + mundo.diamantesRecolectados().toString() + "/" + mundo.diamantesTotales().toString()
  method textColor() = "00FFFF"
}
