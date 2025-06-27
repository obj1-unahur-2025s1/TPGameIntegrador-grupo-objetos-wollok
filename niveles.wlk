import wollok.game.*
import jugador.*
import bloques.*
import mundo.*
import texto.*
import config.*

class Nivel {
  const initialGridMap
  const property diamantesRequeridos
  const property nivelSiguiente = null

  

  method iniciar() {
    administradorDeNivel.reiniciarEstadoDelNivel(diamantesRequeridos)
    self.dibujarMapa()
    
    game.whenCollideDo(personaje, { v =>
      if (v.kindName() == "a Lava") {
        seQuemo.play()
        game.removeVisual(personaje)
        mundo.congelarJuego()
      }
    })

    game.whenCollideDo(personaje, { b =>
      if (b.kindName() == "a Bomba") {
        explosion.play()
        mundo.explotarEn(personaje.position())
        game.removeVisual(b) 
        game.removeVisual(personaje)
        mundo.congelarJuego()
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

object v {
  method decode(x, y) {
    const lava = new Lava(position = game.at(x, y))
    game.addVisual(lava)
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
    [_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,v,v,v,t,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,_,_,_,l,t,t,d,p,t,t,p,d,t,t,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,g,_,_,l,t,t,p,t,t,t,p,t,t,t,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,_,_,_,p,t,t,t,t,t,t,t,t,t,t,l,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,l,v,l,l,l,l,l,l,l,l,l,l,l,l,l,l,_,_,_,_,_,_,_,_]
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
    [_,_,_,_,_,_,_,_,l,p,v,p,l,l,t,l,l,t,t,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,t,t,t,t,t,t,p,t,t,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,t,g,t,d,t,t,t,p,t,d,t,l,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,l,l,_,_,_,_,_,_,_,_,_]
  ], nivelSiguiente = nivel5
)

const nivel5 = new Nivel(
  diamantesRequeridos = 3,
  initialGridMap = [
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,_,_,_,_],
    [_,_,_,_,l,t,p,t,t,b,t,t,_,t,t,t,t,t,t,t,_,_,_,_,_,l,_,_,_,_],
    [_,_,_,_,l,b,d,b,t,j,t,b,t,t,p,t,v,v,v,v,_,_,_,_,_,l,_,_,_,_],
    [_,_,_,_,l,t,t,t,t,t,b,t,t,t,t,_,_,p,_,_,_,_,_,p,_,l,_,_,_,_],
    [_,_,_,_,l,_,_,_,_,t,t,t,t,_,_,_,_,t,t,_,t,v,t,t,v,l,_,_,_,_],
    [_,_,_,_,l,_,_,_,_,_,t,b,t,t,t,t,_,t,t,p,t,b,t,b,t,l,_,_,_,_],
    [_,_,_,_,l,_,_,_,_,_,t,t,t,b,t,b,t,b,t,t,b,t,t,t,t,l,_,_,_,_],
    [_,_,_,_,l,g,_,_,_,_,_,_,_,t,t,t,b,t,b,d,t,t,b,t,d,l,_,_,_,_],
    [_,_,_,_,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,l,_,_,_,_]
  ], nivelSiguiente = final
)

const prueba = new Nivel(
  diamantesRequeridos = 1,
  initialGridMap = [
    [_,_,_,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,t,t,t,t,t,t,t,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,t,t,j,t,t,t,t,p,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,t,t,t,t,t,t,t,_,_,_,_,_,_,_,_,_,_,_,_,_,d,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,t,t,_,t,t,_,_,_,_,_,_,_,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,t,t,_,t,t,_,_,_,_,_,_,g,_],
    [_,_,_,_,_,_,_,_,_,_,_,_,_,_,t,_,_,t,t,t,t,t,_,_,_,_,_,_,_,_], //Recordatorio: Insertar la puerta y que la cantidad de diamantes coincida con los diamantes requeridos
    [_,_,t,p,t,_,_,_,_,_,_,_,_,_,_,_,_,t,t,t,t,t,_,_,_,_,_,_,_,_],
    [t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t,t]
  ]
)

const final = new NivelFinal(diamantesRequeridos=0, initialGridMap =[])