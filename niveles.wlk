import wollok.game.*
import jugador.*
class Nivel {
  const initialGridMap

  method iniciar() {
    self.dibujarMapa()
  }

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

object _ {
  method decode(x, y) {}  // (espacio vacio)
}

object nivel1 inherits Nivel(
  initialGridMap = [
    [_,_,_,p,_,_,p,_,p,_,_,_,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,t,d,t,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,j,_,_,_,_,_,_,_,_,t,t,t,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,d,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,d,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,t,_,t,t,t,t,t,t,t,t,t,t,t,t,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,t,_,t,t,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,t,_,_,_,_,_,t,t,t,t,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,l,p,l,t,p,_,p,_,_,_,_,t,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l]
  ]
){}