extends Node


onready var dialogo = $"../CanvasLayer/Dialogo"
onready var flores = $"../CanvasLayer/Flores"
onready var animator = $"../CanvasLayer/PanelsAnimator"
onready var clientClass = $"../Cliente"
onready var nuevoClienteBtn = $"../CanvasLayer/NuevoCliente"


var dia: int = 0
var cliente: int = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	flores.visible = false
	dialogo.visible = false


func _on_NuevoCliente_button_down():
	newClient()


func newClient():
	cliente += 1
	clientClass.changeSprite(Escena1.scenedata.dias[str(dia)].clientes[str(cliente)].sprite)
	flores.visible = false
	dialogo.visible = true
	nuevoClienteBtn.visible = false
	clientClass.clientEnters()


func changeToDialog(puntos):
	animator.play("QuitarPanel")
	yield(get_tree().create_timer(1), "timeout")
	dialogo.resolverRamo(puntos)
	flores.visible = false
	dialogo.visible = true


func changeToFlowers(requisitos):
	flores.visible = true
	dialogo.visible = false
	flores.requisitos = requisitos
	animator.play("ColocarPanel")


func endDialog():
	dialogo.visible = false
	clientClass.clientExit()
	yield(get_tree().create_timer(2), "timeout")
	nuevoClienteBtn.visible = true

