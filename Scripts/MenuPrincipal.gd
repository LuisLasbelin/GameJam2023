extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("menu pausa")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Salir_pressed():
	get_tree().quit()


func _on_Opciones_pressed():
	get_tree().change_scene("res://Scenes/MenuOpciones.tscn")


func _on_Comenzar_Paritida_pressed():
	get_tree().change_scene("res://Scenes/Tienda2d.tscn")


func _on_MenuPrincipal_ready():
	Global.prevscene = get_tree().current_scene.filename
