import paises.*
import conocimientos.*

class Participante {
	const property pais
	const conocimientos = #{}
	var cantidadDeCommitsHechos
	
	method cantidadDeCommitsHechos() = cantidadDeCommitsHechos
	
	method esCape()
	
	method cumpleConLosRequisitosParaLaCumbre() = conocimientos.contains(programacionBasica)

	method realizarActividad(actividad){
		cantidadDeCommitsHechos += actividad.cantidadDeCommits()
		conocimientos.add(actividad.tema())
	}

}

class Programador inherits Participante{
	var horarDeCapacitacion = 0
	
	override method esCape() = cantidadDeCommitsHechos > 500
	
	method tieneMasCommitQueLaCumbreLePide() = cantidadDeCommitsHechos > cumbre.minimoCommitsAdmitidos()
	
	override method cumpleConLosRequisitosParaLaCumbre() = super() and self.tieneMasCommitQueLaCumbreLePide()

	override method realizarActividad(actividad){
		super(actividad)
		horarDeCapacitacion += actividad.cantidadDeHoras()
	}

}

class Especialista inherits Participante{
	
	override method esCape() = conocimientos.size() > 2
	
	method tieneMasCommitQueLaCumbreLePide() = cantidadDeCommitsHechos > cumbre.minimoCommitsAdmitidos() - 100
	
	method tieneConocimientosEnObjetos() = conocimientos.contains(objetos)
	
	override method cumpleConLosRequisitosParaLaCumbre() = super() and self.tieneMasCommitQueLaCumbreLePide() and self.tieneConocimientosEnObjetos()
}

class Gerente inherits Participante{
	var property empresaDondeTrabaja
	
	override method esCape() = empresaDondeTrabaja.esMultinaciona()
	
	override method cumpleConLosRequisitosParaLaCumbre() = super() and conocimientos.contains(manejoDeGrupos)
}

class Empresa{
	const property paisesEstablecidos = #{}
	
	method esMultinaciona() = paisesEstablecidos.size() >= 3
}
