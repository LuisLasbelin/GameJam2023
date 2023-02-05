extends Node


onready var dialogo = $"../CanvasLayer/Dialogo"
onready var flores = $"../CanvasLayer/Flores"
onready var animator = $"../CanvasLayer/PanelsAnimator"
onready var clientClass = $"../Cliente"
onready var cambioDiaAnimator = $"../CanvasLayer/CambioDia/DiaAnimator"
onready var musica = $"../Musica"
onready var diaText = $"../CanvasLayer/CambioDia/Label/Dia"


var dia: int = -1
var cliente: int = -1
export var condicionales = []


# Called when the node enters the scene tree for the first time.
func _ready():
	condicionales = []
	flores.visible = false
	# first day
	dia += 1
	diaText.text = str(dia+1)
	# El panel dia debe estar en posicion al principio
	yield(get_tree().create_timer(1), "timeout")
	cambioDiaAnimator.play("Salir")
	cliente = -1
	newClient()


func newClient():
	cliente += 1
	if(cliente >= Escena1.scenedata.dias[str(dia)].clientes.size()):
		nextDay()
	var objCliente = Escena1.scenedata.dias[str(dia)].clientes[str(cliente)]
	if(objCliente.has('conditional')):
		if(!condicionales.has(objCliente.conditional)):
			newClient()
			return
	if(Escena1.scenedata.dias[str(dia)].clientes[str(cliente)].has("sprite")):
		clientClass.changeSprite(Escena1.scenedata.dias[str(dia)].clientes[str(cliente)].sprite)
		clientClass.clientEnters()
	flores.visible = false
	yield(get_tree().create_timer(3.5), "timeout")
	dialogo.dialogAnimator.play("Enter")
	dialogo.loadDialog()
	dialogo.loadLines(dialogo.currLine)


func changeToDialog(res):
	animator.play("QuitarPanel")
	dialogo.dialogAnimator.play("Enter")
	yield(get_tree().create_timer(1), "timeout")
	dialogo.dialogoParte += 1
	dialogo.resolverRamo(res)
	flores.visible = false


func changeToFlowers(dialogoObj):
	flores.visible = true
	dialogo.dialogAnimator.play("Exit")
	flores.dialogo = dialogoObj
	flores.textoAyuda(dialogoObj.ayuda)
	flores.reiniciarPosiciones()
	animator.play("ColocarPanel")


func endDialog():
	dialogo.dialogAnimator.play("Exit")
	if(Escena1.scenedata.dias[str(dia)].clientes[str(cliente)].has("sprite")):
		clientClass.clientExit()
	yield(get_tree().create_timer(2), "timeout")
	if(cliente < Escena1.scenedata.dias[str(dia)].clientes.size() - 1):
		yield(get_tree().create_timer(1), "timeout")
		newClient()
	else:
		# llega al final del dia
		nextDay()


func nextDay():
	dia += 1
	if(dia < Escena1.scenedata.dias.size()):
		diaText.text = str(dia+1)
		cambioDiaAnimator.play("Entrar")
		yield(get_tree().create_timer(2), "timeout")
		cambioDiaAnimator.play("Salir")
		cliente = -1
		newClient()
	else: 
		get_tree().change_scene("res://Scenes/Final.tscn")
