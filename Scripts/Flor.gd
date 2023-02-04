extends Control

onready var controler = $"."
onready var imagen = $TextureRect
onready var parentManager = $".."
onready var labelHover = $"../LabelHover"

var mouseOn = false
var pickable = true
var inBouquet = false


func _on_TextureRect_mouse_entered():
	mouseOn = true
	get_node(labelHover).show()


func _on_TextureRect_mouse_exited():
	mouseOn = false
	get_node(labelHover).hide()
	

func _process(delta):
	if(mouseOn && Input.is_action_pressed("ui_select") && pickable):
		parentManager.flowerTaken = controler
		var mousePos = get_global_mouse_position()
		controler.rect_position = Vector2(mousePos.x - imagen.rect_size.x/2, 
			mousePos.y - imagen.rect_size.y/2)
	else:
		parentManager.flowerTaken = null
	if(!inBouquet && rect_position.y > 450 && !Input.is_action_pressed("ui_select")):
		parentManager.flowers.append(controler)
		inBouquet = true
		print(parentManager.flowers)
	if(inBouquet && rect_position.y < 450 && !Input.is_action_pressed("ui_select")):
		parentManager.flowers.erase(controler)
		inBouquet = false
		print(parentManager.flowers)

