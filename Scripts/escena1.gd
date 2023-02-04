extends Node

var scenedata 

func _ready():
	var scene_file = File.new()
	scene_file.open('res://Static/escena1.json', File.READ)
	var scene_json = JSON.parse(scene_file.get_as_text())
	scene_file.close()
	scenedata = scene_json.result
