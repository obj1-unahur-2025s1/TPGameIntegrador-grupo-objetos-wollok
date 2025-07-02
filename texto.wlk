import jugador.*
import mundo.*

object pantallaInicio {
  method image() = "pantallainicio.png"
  method position() = game.at(0, 0)
  method width() = 30
  method height() = 14
}

class TextoInstrucciones {
    const property position
    const property text
    const property textColor = "rgba(202, 199, 204, 0.42)"
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
    game.addVisual(texto1)
    game.addVisual(texto2)
    game.addVisual(texto3)
    game.addVisual(texto4)
    game.addVisual(texto5)
  }
}

const texto1 = new TextoInstrucciones ( 
    position = game.at(14, 12),
    text = "INSTRUCCIONES"
)

const texto2 = new TextoInstrucciones( 
  position = game.at(14, 2),
  text = "OBJETIVO: RECOLECTAR LOS DIAMANTES NECESARIOS EVITANDO PIEDRAS, BOMBAS Y LAVA. SUERTE!"
)

const texto3 = new TextoInstrucciones( 
  position = game.at(14, 1),
  text = "(PRESIONAR ENTER PARA EMPEZAR)"
)

const texto4 = new TextoInstrucciones( 
  position = game.at(18, 9),
  text = "USÁ LAS FLECHAS PARA MOVERTE HACIA ARRIBA, ABAJO, DERECHA E IZQUIERDA"
)

const texto5 = new TextoInstrucciones ( 
  position = game.at(12, 5),
  text = "PRESIONÁ LA TECLA R PARA REINICIAR EL NIVEL"
)

object personajeInst {
    method image() = "personaje.gif"
    method position() = game.origin()
}

object bombaInst {
    method image() = "bombaInst.gif"
    method position() = game.at(25,11)
}

object teclas {
    method image() = "flechas1.gif"
    method position() = game.at(8,8)
} 

object r {
    method image() = "r_1.gif"
    method position() = game.at(18,4)
}
////////////////////////////////////////

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