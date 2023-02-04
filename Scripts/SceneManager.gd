extends Node


onready var dialogo = $"../CanvasLayer/Dialogo"
onready var flores = $"../CanvasLayer/Flores"
onready var animator = $"../CanvasLayer/PanelsAnimator"
onready var clientClass = $"../Cliente"


var dia: int = 0
var cliente: int = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_NuevoCliente_button_down():
	newClient()


func newClient():
	cliente += 1
	clientClass.changeSprite(Escena1.scenedata.dias[str(dia)].clientes[str(cliente)].sprite)
	flores.visible = false
	dialogo.visible = true


func changeToDialog():
	flores.visible = false
	dialogo.visible = true
	dialogo.resolverRamo()
	animator.play("QuitarPanel")


func changeToFlowers(requisitos):
	flores.visible = true
	dialogo.visible = false
	flores.requisitos = requisitos
	animator.play("ColocarPanel")


func endDialog():
	dialogo.visible = false
	clientClass.clientExit()
	yield(get_tree().create_timer(2), "timeout")
	newClient()

