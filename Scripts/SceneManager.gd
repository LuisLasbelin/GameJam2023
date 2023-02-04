extends Node


onready var dialogo = $"../CanvasLayer/Dialogo"
onready var flores = $"../CanvasLayer/Flores"


var dia: int = 0
var cliente: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	changeToDialog()


func changeToDialog(puntos = 999):
	flores.visible = false
	dialogo.visible = true
	dialogo.resolverRamo(puntos)


func changeToFlowers(requisitos):
	flores.visible = true
	dialogo.visible = false
	flores.requisitos = requisitos


func endDialog():
	dialogo.visible = false

