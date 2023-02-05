extends Control


var is_paused = false
var master_bus = AudioServer.get_bus_index("Master")


onready var ControlVolumen = $OpcionesVolumen

func _unhandled_key_input(event):
	if event.is_action_pressed("pause"):
		set_is_paused(!is_paused)


func set_is_paused(value):
	print("cambio variable is paused a ", is_paused)
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


func _on_Salir_pressed():
	get_tree().quit


func _on_Volumen_pressed():
	ControlVolumen.visible = true


func _on_HSliderVolumen_value_changed(value):
	if value != 0:
		AudioServer.set_bus_volume_db(master_bus,value)


func _on_Salir_button_down():
	get_tree().quit()


func _on_Continuar_pressed():
	set_is_paused(false)
	visible = false
