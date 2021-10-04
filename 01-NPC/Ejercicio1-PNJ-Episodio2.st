!classDefinition: #PersonajeNoJugador category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PersonajeNoJugador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersonajeNoJugador class' category: 'Ejercicio1-PNJ-Episodio2'!
PersonajeNoJugador class
	instanceVariableNames: 'cantidadDeInteracciones'!

!PersonajeNoJugador class methodsFor: 'interacciones' stamp: 'fv 10/2/2021 19:27:08'!
olvidarCantidadDeInteracciones
	cantidadDeInteracciones := Dictionary new! !


!PersonajeNoJugador class methodsFor: 'interacciones - privado' stamp: 'fv 10/2/2021 19:51:19'!
interactuarCon: unPersonajeJugadorAInteractuar
		self recordarInteraccionCon:  unPersonajeJugadorAInteractuar. 
		^self responderSegunCantidadDeInteraccionesCon: unPersonajeJugadorAInteractuar! !

!PersonajeNoJugador class methodsFor: 'interacciones - privado' stamp: 'AT 10/2/2021 21:01:25'!
olvidarInteraccionesCon: unPersonajeJugadorAInteractuar
	cantidadDeInteracciones at: unPersonajeJugadorAInteractuar put: 0 ! !

!PersonajeNoJugador class methodsFor: 'interacciones - privado' stamp: 'fv 10/2/2021 19:37:04'!
recordarInteraccionCon: unPersonajeJugadorAInteractuar
	| interacciones |
	interacciones := cantidadDeInteracciones at: unPersonajeJugadorAInteractuar ifAbsent: [0]. 
	cantidadDeInteracciones at: unPersonajeJugadorAInteractuar  put: interacciones + 1! !


!PersonajeNoJugador class methodsFor: 'as yet unclassified' stamp: 'AT 10/3/2021 18:57:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	cantidadDeInteracciones := nil.! !


!classDefinition: #CarolinaLaCurandera category: 'Ejercicio1-PNJ-Episodio2'!
PersonajeNoJugador subclass: #CarolinaLaCurandera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CarolinaLaCurandera class' category: 'Ejercicio1-PNJ-Episodio2'!
CarolinaLaCurandera class
	instanceVariableNames: 'frasesParaContestarADesconocido frasesParaContestarAPrometedor'!

!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'AT 10/2/2021 21:01:25'!
promoverCalificacionDe: unPersonajeJugadorAInteractuar
	PuebloDeRiverwood calificarComoPrometedorA: unPersonajeJugadorAInteractuar. 
	self olvidarInteraccionesCon: unPersonajeJugadorAInteractuar.
	TreborElGuardiaDeSkyrim olvidarInteraccionesCon: unPersonajeJugadorAInteractuar ! !

!CarolinaLaCurandera class methodsFor: 'interacciones - privado' stamp: 'AT 10/1/2021 11:08:33'!
responderSegunCantidadDeInteraccionesCon: unPersonajeJugadorAInteractuar
	| interacciones |
	interacciones := cantidadDeInteracciones  at: unPersonajeJugadorAInteractuar.
	(PuebloDeRiverwood calificacionDe: unPersonajeJugadorAInteractuar)  = 'Prometedor' ifTrue: [^frasesParaContestarAPrometedor at: (interacciones min: 	frasesParaContestarAPrometedor size)].
	
	interacciones = frasesParaContestarADesconocido size ifTrue: [self promoverCalificacionDe: unPersonajeJugadorAInteractuar].
	^frasesParaContestarADesconocido at: (interacciones min: frasesParaContestarADesconocido size)
	
! !


!CarolinaLaCurandera class methodsFor: 'as yet unclassified' stamp: 'AT 10/3/2021 18:57:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	cantidadDeInteracciones := ((Dictionary new) add: (#Hamilton->1); yourself).
	frasesParaContestarADesconocido := #('¿Estás enfermo forastero?' 'Ah, solo quieres conversar' 'Cuando tengas una aflicción, ven a verme' ).
	frasesParaContestarAPrometedor := #('Salud aventurero!!' 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme' ).! !


!classDefinition: #TreborElGuardiaDeSkyrim category: 'Ejercicio1-PNJ-Episodio2'!
PersonajeNoJugador subclass: #TreborElGuardiaDeSkyrim
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreborElGuardiaDeSkyrim class' category: 'Ejercicio1-PNJ-Episodio2'!
TreborElGuardiaDeSkyrim class
	instanceVariableNames: 'frasesParaContestarADesconocido frasesParaContestarAPrometedor'!

!TreborElGuardiaDeSkyrim class methodsFor: 'interacciones - privado' stamp: 'AT 9/29/2021 18:10:10'!
responderSegunCantidadDeInteraccionesCon: unPersonajeJugadorAInteractuar
	| interacciones |
	interacciones := cantidadDeInteracciones  at: unPersonajeJugadorAInteractuar.
	(PuebloDeRiverwood calificacionDe: unPersonajeJugadorAInteractuar)  = 'Prometedor' ifTrue: [^frasesParaContestarAPrometedor at: (interacciones min: 	frasesParaContestarAPrometedor size)].
	^frasesParaContestarADesconocido at: (interacciones min: frasesParaContestarADesconocido size)
	
! !


!TreborElGuardiaDeSkyrim class methodsFor: 'as yet unclassified' stamp: 'AT 10/3/2021 18:57:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	cantidadDeInteracciones := ((Dictionary new) add: (#Hamilton->3); yourself).
	frasesParaContestarADesconocido := #('Hola forastero' '¿Todo bien?' '¿Algún problema?' ).
	frasesParaContestarAPrometedor := #('Bienvenido aventurero!!' 'Espero que tengas una buena estadia en Riverwood' ).! !


!classDefinition: #PruebasDePersonajesNoJugadores category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PruebasDePersonajesNoJugadores
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasDePersonajesNoJugadores class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasDePersonajesNoJugadores class
	instanceVariableNames: ''!

!PruebasDePersonajesNoJugadores class methodsFor: 'personajes' stamp: 'fv 10/2/2021 19:56:03'!
carolinaLaCurandera
	^CarolinaLaCurandera ! !

!PruebasDePersonajesNoJugadores class methodsFor: 'personajes' stamp: 'fv 10/2/2021 19:56:17'!
hamilton
	^#Hamilton! !

!PruebasDePersonajesNoJugadores class methodsFor: 'personajes' stamp: 'fv 10/2/2021 19:56:30'!
tirion
	^#Tirion! !

!PruebasDePersonajesNoJugadores class methodsFor: 'personajes' stamp: 'fv 10/2/2021 19:56:45'!
treborElGuardia
	^ TreborElGuardiaDeSkyrim ! !


!PruebasDePersonajesNoJugadores class methodsFor: 'opiniones e interacciones' stamp: 'fv 10/2/2021 20:04:35'!
hacerQueRiverwoodOlvideTodasSusCalificaciones
	PuebloDeRiverwood olvidarCalificacionesDePersonajes ! !

!PruebasDePersonajesNoJugadores class methodsFor: 'opiniones e interacciones' stamp: 'fv 10/2/2021 20:08:39'!
hacerQueRiverwoodVeaPrometedorAHamilton
	PuebloDeRiverwood calificarComoPrometedorA: self hamilton ! !


!classDefinition: #PruebasInteracionesConCarolinaLaCurandera category: 'Ejercicio1-PNJ-Episodio2'!
PruebasDePersonajesNoJugadores subclass: #PruebasInteracionesConCarolinaLaCurandera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasInteracionesConCarolinaLaCurandera class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasInteracionesConCarolinaLaCurandera class
	instanceVariableNames: ''!

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:48:36'!
test01CuandoLaCuranderaInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Estás enfermo forastero?'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:48:37'!
test02CuandoLaCuranderaInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Ah, solo quieres conversar'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 12:49:16'!
test03CuandoLaCuranderaInteractuaPorTerceraVezConUnPersonajeLeRespondeConSuTercerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Cuando tengas una aflicción, ven a verme'.! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:50:11'!
test04LaCuranderaMantieneDosInteraccionesConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: '¿Estás enfermo forastero?'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: '¿Estás enfermo forastero?'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:50:18'!
test05LaCuranderaMantieneDosInteraccionesCompletasConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: '¿Estás enfermo forastero?'.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: '¿Estás enfermo forastero?'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: 'Ah, solo quieres conversar'.
	Assert that: (self carolinaLaCurandera interactuarCon: self tirion) isEqualTo: 'Cuando tengas una aflicción, ven a verme'.
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Ah, solo quieres conversar'.
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Cuando tengas una aflicción, ven a verme'.
	! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:50:32'!
test06CuandoLaCuranderaInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |	
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Salud aventurero!!'.
! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:50:39'!
test07CuandoLaCuranderaInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.
	
	mensaje := self carolinaLaCurandera interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Toma esta pócima que te hará crecer el pelo. Y cuando tengas una aflicción, ven a verme'.
! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'JMB 9/25/2021 12:50:52'!
test08CuandoLaCuranderaTerminaSuRepertorioDeFrasesConUnPersonajeCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedor
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	
	
	Assert isTrue: (self esVistoPorElPuebloComoPrometedor: self hamilton).! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'AT 10/2/2021 21:09:45'!
test09CuandoLaCuranderaCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaSuHiloDeDialogoConElPersonaje
	self olvidarInteraccionesYOpiniones.
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	
	
	Assert that: (self carolinaLaCurandera interactuarCon: self hamilton) isEqualTo: 'Salud aventurero!!'.! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'cambio de opiniones' stamp: 'AT 10/2/2021 21:47:40'!
test10CuandoLaCuranderaCambiaLaOpinionDelPuebloSobreElPersonajeAPrometedorReiniciaElHiloDeDialogoDelGuardiaConElPersonaje
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	
	self carolinaLaCurandera interactuarCon: self hamilton.
	self carolinaLaCurandera interactuarCon: self hamilton.	
	self carolinaLaCurandera interactuarCon: self hamilton.	

	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Bienvenido aventurero!!'.! !


!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'fv 10/2/2021 19:51:36'!
esVistoPorElPuebloComoPrometedor: unPersonaje
	^(PuebloDeRiverwood calificacionDe: unPersonaje)  = 'Prometedor'.
	! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'fv 10/2/2021 19:29:11'!
hacerQueLaCuranderaOlvideSusInteracciones
	CarolinaLaCurandera olvidarCantidadDeInteracciones .! !

!PruebasInteracionesConCarolinaLaCurandera class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/25/2021 12:48:36'!
olvidarInteraccionesYOpiniones
	self hacerQueLaCuranderaOlvideSusInteracciones.	
	self hacerQueRiverwoodOlvideTodasSusCalificaciones.
! !


!classDefinition: #PruebasInteracionesConTreborElGuardia category: 'Ejercicio1-PNJ-Episodio2'!
PruebasDePersonajesNoJugadores subclass: #PruebasInteracionesConTreborElGuardia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PruebasInteracionesConTreborElGuardia class' category: 'Ejercicio1-PNJ-Episodio2'!
PruebasInteracionesConTreborElGuardia class
	instanceVariableNames: ''!

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:03:53'!
test01CuandoElGuardiaInteractuaPorPrimeraVezConUnPersonajeLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Hola forastero'.
! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:08'!
test02CuandoElGuardiaInteractuaPorSegundaVezConUnPersonajeLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Todo bien?'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'fv 10/2/2021 19:30:53'!
test03CuandoElGuardiaOlvidaInteraccionesPreviasConUnPersonajeAlVolverAInteractuarLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia olvidarCantidadDeInteracciones .
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Hola forastero'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:35'!
test04CuandoElGuardiaInteractuaPorTerceraVezConUnPersonajeLeRespondeConSuTercerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Algún problema?'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con un personaje' stamp: 'JMB 9/25/2021 13:04:44'!
test05CuandoElGuardiaInterctuaYTerminoSuRepertorioDeFrasesConUnPersonajeLeRespondeConSuUltimaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: '¿Algún problema?'.! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con mas de un personaje' stamp: 'AT 9/27/2021 21:25:57'!
test06ElGuardiaMantieneDosInteraccionesConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.

	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: 'Hola forastero'.
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Hola forastero'.! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con mas de un personaje' stamp: 'JMB 9/25/2021 12:53:43'!
test07ElGuardiaMantieneDosInteraccionesCompletasConDiferentesPersonajes
	self olvidarInteraccionesYOpiniones.
	
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: 'Hola forastero'.
	
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: 'Hola forastero'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: '¿Todo bien?'.
	Assert that: (self treborElGuardia interactuarCon: self tirion) isEqualTo: '¿Algún problema?'.
	
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: '¿Todo bien?'.
	Assert that: (self treborElGuardia interactuarCon: self hamilton) isEqualTo: '¿Algún problema?'.
	! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:54:46'!
test08CuandoElGuardiaInteractuaPorPrimeraVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuPrimerFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Bienvenido aventurero!!'.
! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'interacciones con personajes prometedores' stamp: 'JMB 9/25/2021 12:55:02'!
test09CuandoElGuardiaInteractuaPorSegundaVezConUnPersonajeCalificadoPorElPuebloComoPrometedorLeRespondeConSuSegundaFrase
	| mensaje |
	self olvidarInteraccionesYOpiniones.
	self hacerQueRiverwoodVeaPrometedorAHamilton.
	self treborElGuardia interactuarCon: self hamilton.
	
	mensaje := self treborElGuardia interactuarCon: self hamilton.
	
	Assert that: mensaje isEqualTo: 'Espero que tengas una buena estadia en Riverwood'.
! !


!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'fv 10/2/2021 19:29:35'!
hacerQueElGuardiaOlvideSusInteracciones
	TreborElGuardiaDeSkyrim olvidarCantidadDeInteracciones .! !

!PruebasInteracionesConTreborElGuardia class methodsFor: 'opiniones e interacciones' stamp: 'JMB 9/25/2021 12:52:12'!
olvidarInteraccionesYOpiniones
	self hacerQueElGuardiaOlvideSusInteracciones. 	
	self hacerQueRiverwoodOlvideTodasSusCalificaciones.
! !


!classDefinition: #PuebloDeRiverwood category: 'Ejercicio1-PNJ-Episodio2'!
DenotativeObject subclass: #PuebloDeRiverwood
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio1-PNJ-Episodio2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PuebloDeRiverwood class' category: 'Ejercicio1-PNJ-Episodio2'!
PuebloDeRiverwood class
	instanceVariableNames: 'calificacionesDePersonajes'!

!PuebloDeRiverwood class methodsFor: 'interacciones' stamp: 'fv 10/2/2021 19:32:30'!
calificacionDe: unPersonaje
	| calificacion |
	calificacion := calificacionesDePersonajes at: unPersonaje ifAbsent: ['Desconocido'].
	^calificacion ! !

!PuebloDeRiverwood class methodsFor: 'interacciones' stamp: 'fv 10/2/2021 19:32:35'!
calificarComoPrometedorA: unPersonaje
	calificacionesDePersonajes at: unPersonaje  put: 'Prometedor'! !

!PuebloDeRiverwood class methodsFor: 'interacciones' stamp: 'fv 10/2/2021 12:16:57'!
olvidarCalificacionesDePersonajes
	calificacionesDePersonajes := Dictionary new! !


!PuebloDeRiverwood class methodsFor: 'as yet unclassified' stamp: 'AT 10/3/2021 18:57:29'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	calificacionesDePersonajes := ((Dictionary new)).! !

PersonajeNoJugador initializeAfterFileIn!
CarolinaLaCurandera initializeAfterFileIn!
TreborElGuardiaDeSkyrim initializeAfterFileIn!
PuebloDeRiverwood initializeAfterFileIn!