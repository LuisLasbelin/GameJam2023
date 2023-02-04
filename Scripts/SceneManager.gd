extends Node


onready var dialogo = $"../CanvasLayer/Dialogo"
onready var flores = $"../CanvasLayer/Flores"
onready var animator = $"../CanvasLayer/PanelsAnimator"
onready var clientClass = $"../Cliente"
onready var nuevoClienteBtn = $"../CanvasLayer/NuevoCliente"
onready var cambioDiaAnimator = $"../CanvasLayer/CambioDia/DiaAnimator"
onready var musica = $"../AudioStreamPlayer2D"

var dia: int = 0
var cliente: int = -1


# Called when the node enters the scene tree for the first time.
func _ready():
	flores.visible = false
	dialogo.visible = false
	yield(get_tree().create_timer(2), "timeout")
	newClient()


func newClient():
	cliente += 1
	clientClass.changeSprite(Escena1.scenedata.dias[str(dia)].clientes[str(cliente)].sprite)
	flores.visible = false
	dialogo.visible = true
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
	if(cliente < Escena1.scenedata.dias[str(dia)].clientes.size() - 1):
		yield(get_tree().create_timer(2), "timeout")
		newClient()
	else:
		# llega al final del dia
		nextDay()


func nextDay():
	dia += 1
	cambioDiaAnimator.play("Entrar")
	yield(get_tree().create_timer(2), "timeout")
	cambioDiaAnimator.play("Salir")
	cliente = -1
	newClient()
