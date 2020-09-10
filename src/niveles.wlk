import cosillas.*
import homero.*
import wollok.game.*

object nivel1{
	

const barraUranio = new Barra(horasDeTrabajo = 1,image = "barraVerdeUranio.png",position = movimiento.posicionAleatoria(1,5))
const dona = new Dona (horasDeTrabajo = -2,position = movimiento.posicionAleatoria(2,5), image="donut.png")		
const barraRoja = new Barra(horasDeTrabajo = 2,image = "barraRojaUranio.png",position = movimiento.posicionAleatoria(1,4))

const fondo = new Elementos (image = "plantaNuclear.jpeg", position = game.origin())

	method nivelAPasar() = 2
	
	method iniciar(){
		config.inicializarNivel(self,homero)
	}
		
	method agregarPersonajes(){		
			game.addVisual(fondo)
			game.addVisual(homero)
			game.addVisual(dona)
			game.addVisual(barraUranio)
			game.addVisual(barraRoja)
			game.showAttributes(homero)	
		}
		
}

object nivel2{

const dineroPequenio = new ElementosSegundoNivel (image = "dineroPequenio.png",position = movimiento.posicionAleatoria(1,5) , valorMonetario = 1, valorAlcoholico = 0)

const dineroGrande = new ElementosSegundoNivel(image = "dineroGrande.png",position = movimiento.posicionAleatoria(4,5), valorMonetario = 2, valorAlcoholico = 0)
 
const cerveza = new ElementosSegundoNivel(image = "cerveza.jpeg", position = movimiento.posicionAleatoria(2,3) , valorMonetario = -3, valorAlcoholico =  1, esDinero = false)

const fondo = new Elementos (image = "bar_moe.jpeg", position = game.origin())


	method elegirDondeCambiar() {
		keyboard.num1().onPressDo {nivel1.iniciar()}
	}
	
	method agregarPersonajes(){
			game.addVisual(fondo)
			game.addVisual(homero)
			game.addVisual(dineroPequenio)
			game.addVisual(dineroGrande)
			game.addVisual(cerveza)
			game.showAttributes(homero)
	}
	
	
	method iniciar() {
		config.inicializarNivel(self,homero)
	}
	
}

object nivel3 {
	
	const primerAuto = new Auto (image = "primerAuto.png" ,position = game.at(10,2),esBarraDeUranio = false)
	const segundoAuto = new Auto (image = "primerAuto.png", position = game.at(1,3) ,esBarraDeUranio = false)
	const tercerAuto =  new Auto (image = "segundoAuto.png",position = game.at(3,4),esBarraDeUranio = false)
	const cuartoAuto =  new Auto (image = "segundoAuto.png",position = game.at(2,5),esBarraDeUranio = false)
	const barraUranio = new BarraTercerNivel(image = "barraVerdeUranio.png",position = game.at(6,10),esBarraDeUranio = true)
	const barraRoja = new BarraTercerNivel(image = "barraRojaUranio.png",position = game.at(1,11),esBarraDeUranio = true)
	const fondo = new Elementos (image = "ruta.jpeg", position = game.origin())

	method elegirDondeCambiar() {
		keyboard.num1().onPressDo {nivel1.iniciar()}
		keyboard.num2().onPressDo {nivel2.iniciar()}
		keyboard.num3().onPressDo {self.iniciar()}
	}

	method iniciar() {
		
		config.inicializarNivel(self,autoHomero)
		
		primerAuto.moverseAutomaticamente()
		segundoAuto.moverseAutomaticamente()
		tercerAuto.moverseAutomaticamente()
		cuartoAuto.moverseAutomaticamente()
		barraUranio.moverseAutomaticamente()
		barraRoja.moverseAutomaticamente()
	}

	method agregarPersonajes(){
		game.addVisual(fondo)
		game.addVisual(barraRoja)
		game.addVisual(barraUranio)
		game.addVisual(primerAuto)
		game.addVisual(autoHomero)
		game.addVisual(segundoAuto)
		game.addVisual(tercerAuto)
		game.addVisual(cuartoAuto)
		game.addVisual(barraDeVidas)
	}
}

object config {

	const gameOver = new Elementos (image = "gameOver.jpeg",position = game.origin())
	const ganar = new Elementos (image = "ganarJuego.jpeg", position = game.origin())
	
	method configurarColisiones(personaje){
		game.onCollideDo(personaje, {element => element.sumarEfectos(personaje)})	
	}
	
	method configurarTeclado(personaje){
	keyboard.d().onPressDo { game.say(personaje, "D'oh!") game.sound("homero-ouch-2.mp3") }
	keyboard.up().onPressDo {personaje.moverse(personaje.position().up(1)) }
	keyboard.down().onPressDo {personaje.moverse(personaje.position().down(1)) }
	keyboard.left().onPressDo {personaje.moverse(personaje.position().left(1)) }
	keyboard.right().onPressDo {personaje.moverse(personaje.position().right(1)) }
	}
	
	method inicializarNivel(nivel,personaje){
		game.clear()
		nivel.agregarPersonajes()
		personaje.iniciar()
		self.configurarTeclado(personaje)
		self.configurarColisiones(personaje)
	}
	
	
	method concluirJuego(fondo){
		game.clear()
		game.addVisual(fondo)
	}
	
	method finalizarJuego(nivelAPasar) {
		
		self.concluirJuego(gameOver)
		if(nivelAPasar != "pantalla final") {
		nivelAPasar.elegirDondeCambiar()	
		} else nivel3.elegirDondeCambiar()
		
	}
	
	method ganarJuego() {
		self.concluirJuego(ganar)
	}
	
	method cambiarDeNivel(nivel){
		game.title()
		game.clear()
		nivel.iniciar()
	}

}
