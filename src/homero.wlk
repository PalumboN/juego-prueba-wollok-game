import cosillas.*
import niveles.*
import wollok.game.*

object movimiento {
	
	method estaEnLimite(limiteEnX,limiteEnY,posicion) = posicion.x() == limiteEnX || posicion.x() == limiteEnY || posicion.y() == limiteEnY || posicion.y() == limiteEnX
	
	method  posicionAleatoria(x,y) = game.at(x.randomUpTo(11),y.randomUpTo(11))
	
	method estaEnOrigen(posicion) = (posicion.x() == 0 && posicion.y() == 0)
	
	method moverse(posicion,personaje) {
		if(!(self.estaEnLimite(-1,14,posicion) || self.estaEnOrigen(posicion))){
		personaje.position(posicion)
		}
	}
}

object barraDeVidas {
	
	var property position = game.at(0,14)
	
	method image() {
		if(autoHomero.vidas() == 3) return "tres_corazones.png"
		if(autoHomero.vidas() == 2) return "dos_corazones.png"
		else (return "un_corazon.png")
	}
}
	
object homero {
	
	var horasAcumuladas = 0
	
	var dinero = 5
	
	var nivelEbriedad = 0
	
	var property position = game.at(0,1)
	
	method dinero() = dinero
	method nivelEbriedad() = nivelEbriedad
	
	method iniciar() {
		horasAcumuladas = 0
		dinero = 5
		nivelEbriedad = 0
	}
				   
	method image() {
	
	if(self.comioDemasiado()){
		return "HomerDoh.png"
	}
	else {return "homer.png"}
	}
	
	method horasAcumuladas() = horasAcumuladas
	
	method moverse(nuevaPosicion) {movimiento.moverse(nuevaPosicion,self)}
	
	
	method sumarHorasDeTrabajo(numero) {horasAcumuladas += numero}
	method sumarDinero(numero) {dinero += numero}
	method sumarNivelDeEbriedad(numero) {nivelEbriedad += numero}
	
	
	method agarrarObjeto(objeto){
		objeto.sumarEfectos(self)
	}
		
	method decirDoh() = game.say(self,"D'oh!")
	
	method comioDemasiado() = horasAcumuladas <= -4

	
	method decirIuju() = game.say(self, "Iuju!!!")
	
	
	method seQuedoSinPlata() = dinero <= 0
	
	method bebioDemasiado() = nivelEbriedad >= 8
}


object autoHomero {
	
	var property position = game.at(5,5)	
	var property radioactivo = false
	var property vidas = 3
	var property autosDestruidos = 0
	
	method image() {
	
	if(self.radioactivo()){
		return "auto_homero_radioactivo.png"
	}
	else {return "auto_homero.png"}
	}
	
	method iniciar() {
		radioactivo = false
		vidas = 3
		autosDestruidos = 0
	}
	
	method moverse(nuevaPosicion) {
		 movimiento.moverse(nuevaPosicion,self) }
	
}

object victoriaOderrota {
	
	method evaluarVictoria(condicionParaPerder, condicionParaGanar, nivelAPasar) {
		
		if (condicionParaPerder) config.finalizarJuego(nivelAPasar)
		
		if (condicionParaGanar) {
			if(nivelAPasar == "pantalla final") config.ganarJuego()
			else config.cambiarDeNivel(nivelAPasar)
		}
	}
}


	


