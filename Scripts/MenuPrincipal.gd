extends Control

onready var menuPausa = $MenuPausa


# Called when the node enters the scene tree for the first time.
func _ready():
	menuPausa.is_paused = false


func _on_Salir_pressed():
	get_tree().quit()


func _on_Opciones_pressed():
	menuPausa.set_is_paused(true)


func _on_Comenzar_Paritida_pressed():
	get_tree().change_scene("res://Scenes/Tienda2d.tscn")


func _on_MenuPrincipal_ready():
	Global.prevscene = get_tree().current_scene.filename
