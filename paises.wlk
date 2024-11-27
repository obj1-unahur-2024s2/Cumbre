class Pais {
	const paisesConConflicto = #{}
	
	method esAuspicianteDeLaCumbre() = cumbre.esPaisAuspiciante(self)
	
	method registrarConflictos(listaPaises){
		paisesConConflicto.addAll(listaPaises)
	}
	method terminarConflicto(unPais){
		paisesConConflicto.remove(unPais)
	}
	
	method esConflictivoParaLaCumbre() = paisesConConflicto.any({p => p.esAuspicianteDeLaCumbre()})
	
}

object cumbre{
	const property paisesAuspiciantes = #{}
	const property participantesDeLaCumbre = #{}
	var property minimoCommitsAdmitidos = 300
	const actividadesRealizadas = #{}
	
	method agregarPaises(listaPaises){
		paisesAuspiciantes.addAll(listaPaises)
	}
	
	method agregarParticipante(unParticipante){
		if (not self.puedeIngresarEnLaCumbre(unParticipante)){
			self.error("no puede ingresar a la cumbre")
		}
		participantesDeLaCumbre.add(unParticipante)
	}
	
	method agregarParticipantes(listaParticipantes){
		participantesDeLaCumbre.addAll(listaParticipantes)
	}
	
	method esSegura() = participantesDeLaCumbre.all({p => self.puedeIngresarEnLaCumbre(p)})
	
	method quitarParticipante(unaPersona){
		participantesDeLaCumbre.remove(unaPersona)
	}
	
	method cantidadDeParticipantes() = participantesDeLaCumbre.size()
	
	method paisesDeParticipantes() = participantesDeLaCumbre.map({part => part.pais()}).asSet()
	method cantidadDeParticipantesDe(unPais) = participantesDeLaCumbre.count({p => p.pais() == unPais})
	method paisConMasParticipantes() = self.paisesDeParticipantes().max({pais => self.cantidadDeParticipantesDe(pais)})
	
	method esPaisAuspiciante(unPais) = paisesAuspiciantes.contains(unPais)
	
	method paisesExtranjeros() = self.paisesDeParticipantes().filter({ pais => not self.esPaisAuspiciante(pais)})

	method esRelevante() = participantesDeLaCumbre.all({ p => p.esCape()})

	method hayMasDeDosPersonasDelPais(unPais) = participantesDeLaCumbre.count({p => p.pais() == unPais}) > 2 
	method esDePaisConflictivo(unaPersona) = unaPersona.pais().esConflictivoParaLaCumbre()
	method tieneRestringidoElAcceso(unaPersona) = self.esDePaisConflictivo(unaPersona) or self.hayMasDeDosPersonasDelPais(unaPersona.pais()) and not self.esPaisAuspiciante(unaPersona.pais())
	method puedeIngresarEnLaCumbre(unaPersona){
		return unaPersona.cumpleConLosRequisitosParaLaCumbre() and not self.tieneRestringidoElAcceso(unaPersona)
	}
	
	method realizarActividad(actividad){
		participantesDeLaCumbre.forEach({p => p.realizarActividad(actividad)})
		actividadesRealizadas.add(actividad)
	}
	
	method totalDeHorasDeActividad() = actividadesRealizadas.sum({a => a.cantidadDeHoras()})
}
