extends Control


onready var sceneManager = $"../../SceneManager"
onready var colocadaEffect = $Colocada
onready var quitadaEffect = $Quitada
onready var textAyuda = $Ayuda
onready var floresCont = $FloresCont
onready var area = $Ramo/Area2D

var flowerTaken = null
var flowers = []
var ramo = []
var dialogo = {}
var ayuda = ""
var posicionesIniciales = []


func reiniciarPosiciones():
	if(posicionesIniciales.size() < 1):
		for i in floresCont.get_children():
			posicionesIniciales.append(i.rect_position)
	var j = 0
	for i in floresCont.get_children():
		i.rect_position = posicionesIniciales[j]
		j += 1


func textoAyuda(txt):
	textAyuda.text = "Ayuda: " + txt


func _on_Volver_button_down():
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		flowers.append(body.get_parent())
	
	print(flowers)
	if(flowers.size() > 2):
		for flower in flowers:
			ramo.append(flower.name)
		var res = puntuarRamo()
		sceneManager.changeToDialog(res)


# Recibe una lista con los nombres de las flores que hay en el ramo y dos listas,
# especificando cuales quiere y cuales no. Puntua con eso.
func puntuarRamo():
	var puntos: int = 0
	var alt: bool = false
	for flor in ramo:
		if flor in dialogo.requisitos.aceptados:
			puntos += 1
		if flor in dialogo.requisitos.denegados:
			puntos -= 2
		if(dialogo.requisitos.has("especial")):
			if flor in dialogo.requisitos.especial:
				alt = true
				puntos += 1
	
	print("Ramo analizado.")
	var res = 0
	# Si los puntos son positivos
	if(puntos > 0):
		if(alt):
			res = dialogo.resultados.positivoAlt
		else:
			res = dialogo.resultados.positivo
		print("Resultado positivo, siguiente parte: ", res)
	else: 
		res = dialogo.resultados.negativo
		print("Resultado negativo, siguiente parte: ", res)
	# carga la parte res
	return res


func _on_Area2D_body_entered(body):
	colocadaEffect.play()


func _on_Area2D_body_exited(body):
	quitadaEffect.play()
