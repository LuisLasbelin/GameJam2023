extends Control


onready var sceneManager = $"../SceneManager"

var flowerTaken = null
var flowers = []
var ramo = []
var requisitos = {}


func _on_Volver_button_down():
	for flower in flowers:
		ramo.append(flower.name)
	var puntos = puntuarRamo()
	sceneManager.changeToDialog(puntos)


# Recibe una lista con los nombres de las flores que hay en el ramo y dos listas,
# especificando cuales quiere y cuales no. Puntua con eso.
func puntuarRamo():
	var puntos: int = 0
	for flor in ramo:
		if flor in requisitos.aceptados:
			puntos += 1
		if flor in requisitos.denegados:
			puntos -= 1
	
	return puntos
