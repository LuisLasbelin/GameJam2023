extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("pausa")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Volver_pressed():
	get_tree().change_scene("res://Scenes/MenuPrincipal.tscn")


func _on_Continuar_pressed():
	pass # Replace with function body.
	


func _on_MenuOpciones_ready():
	Global.prevscene = get_tree().current_scene.filename
