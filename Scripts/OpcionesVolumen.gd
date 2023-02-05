extends Control

onready var parent = $"."
onready var muestraEfecto = $MuestraEfecto

func _on_Volver_pressed():
	parent.visible = false


func _on_OpcionesVolumen_ready():
	pass #Global.prevscene = get_tree().current_scene.filename


func _on_HSliderVolumen_value_changed(value):
	if value != 0:
		AudioServer.set_bus_volume_db(1, value)


func _on_EffectsSlider_value_changed(value):
	if value != 0:
		AudioServer.set_bus_volume_db(2, value)
	
	muestraEfecto.play()
