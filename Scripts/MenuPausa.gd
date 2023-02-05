extends Control


var is_paused = false setget set_is_paused
var master_bus = AudioServer.get_bus_index("Master")


onready var ControlVolumen = $OpcionesVolumen

func _unhandled_key_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused


func set_is_paused(value):
	print("cambio variable is paused a ")
	print(is_paused)
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hola Menu Pausas")


func _on_Salir_pressed():
	get_tree().quit


func _on_MenuPausa_ready():
	Global.prevscene = get_tree().current_scene.filename
	print("prevscene")
	print(Global.prevscene)


func _on_Volumen_pressed():
	
	ControlVolumen.visible = true


func _on_Continuar_button_up():
	pass # Replace with function body.


func _on_HSliderVolumen_value_changed(value):
	if value != 0:
		AudioServer.set_bus_volume_db(master_bus,value)


func _on_Salir_button_down():
	get_tree().quit()

