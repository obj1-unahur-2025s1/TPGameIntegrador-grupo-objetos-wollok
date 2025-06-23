import wollok.game.*
import jugador.*
class Nivel {
  const initialGridMap
  const diamantesRequeridos

  method iniciar() {
    mundo.reiniciarContador(diamantesRequeridos)
    self.dibujarMapa()
  }

  method nivelSiguiente() = null

  method dibujarMapa() {
    var y = game.height() - 1
    initialGridMap.forEach({fila =>
      var x = 0
      fila.forEach({celda =>
        celda.decode(x, y)
        x += 1
      })
      y -= 1
    })
  }
}

object t {
  method decode(x, y) {
    const tierra = new Tierra(position = game.at(x, y))
    game.addVisual(tierra)
  }
}

object p {
  method decode(x, y) {
    const piedra = new Piedra(position = game.at(x, y))
    game.addVisual(piedra)
    mundo.agregarPiedra(piedra)
  }
}

object l {
  method decode(x, y) {
    const ladrillo = new Ladrillo(position = game.at(x, y))
    game.addVisual(ladrillo)
  }
}

object j {
  method decode(x, y) {
    personaje.position(game.at(x, y))
    game.addVisual(personaje)
  }
}

object d {
  method decode(x, y) {
    const diamante = new Diamante(position = game.at(x, y))
    game.addVisual(diamante)
    mundo.agregarDiamante(diamante)
  }
}

object g {
  var property posicionPuerta = null

  method decode(x, y) {
    posicionPuerta = game.at(x, y)
  }

  method posicion() = posicionPuerta
}

object _ {
  method decode(x, y) {}  // (espacio vacio)
}

object nivel1 inherits Nivel(
  diamantesRequeridos = 2,
  initialGridMap = [
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,l,_,_,_,_,_,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,l,_,_,_,_,_,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,l,j,_,d,_,p,_,g,l,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,l,t,t,t,t,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,l,t,t,t,d,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,l,t,t,t,t,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,_,_,_,_,_,_,_,_,_,_,_,_]
  ]
){
  override method nivelSiguiente() = nivel2
}

object nivel2 inherits Nivel(
  diamantesRequeridos = 3,
  initialGridMap = [
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,l,l,l,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,_,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,_,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,_,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,j,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,p,p,g,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,l,l,t,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,d,d,d,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l]
  ]
){
  override method nivelSiguiente() = nivel3
}

object nivel3 inherits Nivel(
  diamantesRequeridos = 3,
  initialGridMap = [
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,l,l,l,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,_,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,_,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,_,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,j,_,_,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,p,p,g,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,l,l,t,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,t,t,t,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,l,d,d,d,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l]
  ]
){
  
}