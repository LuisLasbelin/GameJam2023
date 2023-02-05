extends Control

onready var controler = $"."
onready var imagen = $TextureRect
onready var parentManager = $"../.."
onready var label = $Label
onready var ramoCont = $"../../Ramo"


var mouseOn = false
var pickable = true
var inBouquet = false


func _ready():
	label.visible = false


func _on_TextureRect_mouse_entered():
	mouseOn = true


func _on_TextureRect_mouse_exited():
	mouseOn = false


func _process(delta):
	if(mouseOn && !Input.is_action_pressed("ui_select")):
		label.visible = true
	else:
		label.visible = false
	if(mouseOn && Input.is_action_pressed("ui_select") && pickable):
		parentManager.flowerTaken = controler
		var mousePos = get_global_mouse_position()
		controler.rect_position = Vector2(mousePos.x - controler.rect_size.x/2, 
			mousePos.y - controler.rect_size.y/2)
	else:
		parentManager.flowerTaken = null
#	# Flor colocada
#	# Ahora se hace desde Flores.gd
#	if(!inBouquet && ramoCont.rect_position.y < controler.rect_position.y && !Input.is_action_pressed("ui_select")):
#		parentManager.flowers.append(controler)
#		inBouquet = true
#		parentManager.colocadaEffect.play()
#		print(parentManager.flowers)
#	# Flor sacada
#	if(inBouquet && ramoCont.rect_position.y > controler.rect_position.y && !Input.is_action_pressed("ui_select")):
#		parentManager.flowers.erase(controler)
#		inBouquet = false
#		parentManager.quitadaEffect.play()
#		print(parentManager.flowers)

