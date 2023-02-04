extends Node2D


onready var animator = $AnimationPlayer
onready var dialogo = $"../CanvasLayer/Dialogo"
onready var sprite = $Sprite


func llegada():
	dialogo.loadDialog()


func clientEnters():
	animator.play("Entrada")


func clientExit():
	animator.play("Salida")


func clientHabla():
	animator.play("Hablar")


func changeSprite(route):
	sprite.texture = load(route)
