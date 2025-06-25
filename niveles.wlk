import wollok.game.*
import jugador.*
import bloques.*
import mundo.*
import texto.*
import config.*

class Nivel {
  const initialGridMap
  const diamantesRequeridos
  const property nivelSiguiente = null

  method iniciar() {
    mundo.reiniciarContador(diamantesRequeridos)
    self.dibujarMapa()

    game.whenCollideDo(personaje, {b =>
    if (b.kindName() == "a Bomba") {
      explosion.play()
      personaje.perderVida()

    if (personaje.vidas() > 0) {
      game.onTick(500, "reinicio", {
        mundo.reiniciarNivel()
      })
    }
    }
    })
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

class NivelFinal inherits Nivel {
  override method iniciar() {
    game.clear()
    game.addVisual(textoFinal)
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

object b {
  method decode(x, y) {
    const bomba = new Bomba(position = game.at(x, y))
    game.addVisual(bomba)
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

const nivel1 = new Nivel(
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
  ], nivelSiguiente = nivel2
)


const nivel2 = new Nivel(
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
    [_,_,_,_,_,_,_,_,_,_,_,l,l,l,l,l,_,_,_,_,_,_,_,_,_,_,_,_,_,_]
  ], nivelSiguiente = nivel3
)

const nivel3 = new Nivel(
  diamantesRequeridos = 3,
  initialGridMap = [
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,_,_,_,_,_,p,_,_,_,_,_,_,_,_,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,_,_,_,_,p,p,p,_,_,_,_,_,_,_,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,j,_,_,p,p,p,p,p,_,d,_,_,_,_,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,l,l,l,t,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,_,_,_,l,t,t,d,p,t,t,p,d,t,t,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,g,_,_,l,t,t,p,t,t,t,p,t,t,t,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,_,_,_,p,t,t,t,t,t,t,t,t,t,t,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,_,_,_,_,_,_,_,_]
  ], nivelSiguiente = nivel4
)

const nivel4 = new Nivel(
  diamantesRequeridos = 4,
  initialGridMap = [
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,l,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,t,t,t,p,t,t,t,t,t,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,t,t,t,p,t,t,t,t,t,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,t,d,t,p,t,t,t,d,d,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,t,t,l,l,t,l,l,p,p,p,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,t,t,l,t,t,j,l,t,t,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,t,p,l,t,p,t,l,t,t,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,p,p,p,l,l,t,l,l,t,t,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,t,t,t,t,t,t,p,t,t,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,g,t,d,t,t,t,p,t,d,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,l,l,_,_,_,_,_,_,_,_,_]
  ], nivelSiguiente = nivel5
)

const nivel5 = new Nivel(
  diamantesRequeridos = 3,
  initialGridMap = [
    [_,_,_,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,t,t,_,t,t,t,t,t,t,t,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,t,b,d,b,t,j,t,t,t,t,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,t,t,t,t,t,t,t,t,t,b,t,t,t,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,t,t,t,t,_,_,_,_,_,t,t,t,_,_,_,_,t,t,_,t,t,_,_,_,_,_,_,_,_],
    [_,t,t,t,t,_,_,_,_,_,t,b,t,t,t,_,_,t,t,_,t,t,_,_,_,_,_,_,_,_],
    [t,t,b,t,t,_,_,_,_,_,t,t,t,t,t,t,t,b,t,t,t,t,_,_,_,_,_,_,_,_],
    [t,d,t,p,t,_,_,_,_,_,_,_,_,t,t,t,t,t,b,d,b,t,_,_,_,_,_,_,_,_],
    [t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t]
  ], nivelSiguiente = final
)

const prueba = new Nivel(
  diamantesRequeridos = 4,
  initialGridMap = [
    [_,_,_,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,t,t,t,t,t,t,t,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,t,t,j,t,t,t,t,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,t,t,t,t,t,t,t,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,t,t,_,t,t,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,t,t,_,t,t,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,t,_,_,t,t,t,t,t,_,_,_,_,_,_,_,_],
    [_,_,t,p,t,_,_,_,_,_,_,_,_,_,_,_,_,t,t,t,t,t,_,_,_,_,_,_,_,_],
    [t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t]
  ]
)

const final = new NivelFinal(diamantesRequeridos=0, initialGridMap =[])