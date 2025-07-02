import jugador.*
import mundo.*

object pantallaInicio {
  method image() = "pantallainicio.png"
  method position() = game.at(0, 0)
  method width() = 30
  method height() = 14
}

object instrucciones {
  method image() = "cueva.png"
  method position() = game.at(0, 0)
  method width() = 30
  method height() = 14

  method elementos() {
    game.addVisual(personajeInst)
    game.addVisual(bombaInst)
    game.addVisual(r)
    game.addVisual(teclas)
    game.addVisual(textoInstruccionesFlechas)
    game.addVisual(textoInstruccionesR)
    game.addVisual(textoInstrucciones)
    game.addVisual(textoInstrucciones2)
    game.addVisual(textoInstrucciones3)
  }
}

object textoInstrucciones {
  method position() = game.at(14, 12)
  method text() = "INSTRUCCIONES"
  method textColor() = "rgba(202, 199, 204, 0.42)"
}

object textoInstrucciones2 {
  method position() = game.at(14, 2)
  method text() = "OBJETIVO: RECOLECTAR LOS DIAMANTES NECESARIOS EVITANDO PIEDRAS, BOMBAS Y LAVA. SUERTE!"
  method textColor() = "rgba(202, 199, 204, 0.42)"
}

object textoInstrucciones3 {
  method position() = game.at(14, 1)
  method text() = "(PRESIONAR ENTER PARA EMPEZAR)"
  method textColor() = "rgba(255, 0, 0, 0.8)"
}

object personajeInst {
    method image() = "personaje.gif"
    method position() = game.origin()
}

object bombaInst {
    method image() = "bombaInst.gif"
    method position() = game.at(25,11)
}

object textoInstruccionesFlechas {
  method position() = game.at(18, 9)
  method text() = "USÁ LAS FLECHAS PARA MOVERTE HACIA ARRIBA, ABAJO, DERECHA E IZQUIERDA"
  method textColor() = "rgba(202, 199, 204, 0.42)"
}

object textoInstruccionesR {
  method position() = game.at(12, 5)
  method text() = "PRESIONÁ LA TECLA R PARA REINICIAR EL NIVEL"
  method textColor() = "rgba(202, 199, 204, 0.42)"
}

object teclas {
    method image() = "flechas1.gif"
    method position() = game.at(8,8)
} 

object r {
    method image() = "r_1.gif"
    method position() =game.at(18,4)
}

object textoDiamantes {
  method position() = game.at(1, 13)
  method text() = "Diamantes: " + progreso.diamantesRecolectados().toString() + "/" + mundo.diamantesTotales().toString()
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
  method position() = game.at(14, 7)
  method text() = "¡Felicidades! Juego completado."
  method textColor() = "00FF00"
  method fontSize() = 40
}

object textoReinicio{
  method position() = game.at(14, 13)
  method text() = "Presiona R para reiniciar el nivel."
  method textColor() = "00FF00FF"
  method fontSize() = 24
}