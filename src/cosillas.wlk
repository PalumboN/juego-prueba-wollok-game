import homero.*
import wollok.game.*
import niveles.*

class Elementos {
	var image
	var position 
	
	method position() = position
	method image() = image
	
	method cambiarPosicion(nuevaPosicion){
		if(!(movimiento.estaEnLimite(-1,13,nuevaPosicion)))
		position = nuevaPosicion
	}
	
	
	method reUbicar(){			
		var nuevaPosicion = new Position (x=1.randomUpTo(11),y=1.randomUpTo(11))
		if(game.getObjectsIn(nuevaPosicion).isEmpty())
			self.cambiarPosicion(nuevaPosicion)
		else
			self.reUbicar()	
	}
	
}

class ElementosPrimerNivel inherits Elementos {
	
	var horasDeTrabajo
	
	method horasDeTrabajo() = horasDeTrabajo
	
	method sumarEfectos(personaje)
	}
	
	
class Dona inherits ElementosPrimerNivel{
	
	override method sumarEfectos(personaje){
		personaje.sumarHorasDeTrabajo(horasDeTrabajo)
		personaje.decirDoh()
		self.reUbicar()
		victoriaOderrota.evaluarVictoria(homero.horasAcumuladas() <= -4, homero.horasAcumuladas() >= 10, nivel2)
	
		}

}



class Barra inherits ElementosPrimerNivel{
	
	override method sumarEfectos(personaje){
		personaje.sumarHorasDeTrabajo(horasDeTrabajo)
		self.reUbicar()
		victoriaOderrota.evaluarVictoria(homero.horasAcumuladas() <= -4, homero.horasAcumuladas() >= 10, nivel2)
	}
}



class ElementosSegundoNivel inherits Elementos {
	
	const property valorMonetario
	const property valorAlcoholico
	const property esDinero = true
	
	method sumarEfectos(personaje){
		personaje.sumarDinero(valorMonetario)
		personaje.sumarNivelDeEbriedad(valorAlcoholico)
		if(esDinero) {personaje.decirIuju()}
		self.reUbicar()
		victoriaOderrota.evaluarVictoria(homero.seQuedoSinPlata(), homero.bebioDemasiado(),nivel3)
	}
}

class ElementosTercerNivel inherits Elementos {
	
	var property esBarraDeUranio
	
	method modificarAuto(personaje)
	
	method sumarEfectos(personaje){
	self.modificarAuto(personaje)
	self.reUbicar() 
	victoriaOderrota.evaluarVictoria(autoHomero.vidas() == 0,autoHomero.autosDestruidos() == 5,"pantalla final")
	}
		
	method evaluarDireccion(controlador,inicio,fin) = controlador.between(inicio,fin)
	
	method moverseAutomaticamente(){
		
		game.onTick(250,"MoverseAutomaticamente",{
		var controlador = (1..100).anyOne()
		
		if(self.evaluarDireccion(controlador,1,25)) self.cambiarPosicion(self.position().up(1))
		if(self.evaluarDireccion(controlador,26,50)) self.cambiarPosicion(self.position().down(1))
		if(self.evaluarDireccion(controlador,51,75)) self.cambiarPosicion(self.position().left(1))
		if(self.evaluarDireccion(controlador,76,100)) self.cambiarPosicion(self.position().right(1))					
		})
		
	}
}

class BarraTercerNivel inherits ElementosTercerNivel {
	
	override method modificarAuto(personaje){
		if(personaje.radioactivo()) {config.finalizarJuego("pantalla final")}
		else {personaje.radioactivo(true)
		game.schedule(5000,{=>personaje.radioactivo(false)})}	
	}
}

class Auto inherits ElementosTercerNivel {
	
	override method modificarAuto(personaje){
	if(personaje.radioactivo()) {personaje.autosDestruidos(personaje.autosDestruidos() + 1)
	}else {personaje.vidas(personaje.vidas() - 1)}
	personaje.radioactivo(false)
		}
}
	





	