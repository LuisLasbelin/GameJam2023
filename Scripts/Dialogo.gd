extends Control


onready var dialogeText = $Label
onready var sceneManager = $"../../SceneManager"
onready var cliente = $"../../Cliente"
onready var nombre = $Nombre
onready var audioPlayer = $AudioEffects
onready var speakingPlayer = $SpeakingEffect


var percText = 0
export var waiting = 0.025
var lineas = []
var currLine = 0
var dialogo = {}
var dialogoParte = 0
var escribiendo = false
var textoPausado = false


# Called when the node enters the scene tree for the first time.
func _ready():
	currLine = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Button_pressed():
	if(!escribiendo):
		nextLine()


func loadDialog():
	dialogo = Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].dialogo


# Carga las lineas de la parte enviada y el valor dialogo del script
func loadLines(_part):
	lineas = dialogo[str(_part)].lineas
	nextLine()


func resolverRamo(puntos = 999):
	if(puntos != 999):
		print("Ramo analizado.")
		# Si los puntos son positivos
		if(puntos > 0):
			dialogoParte = dialogo[str(dialogoParte)].resultados.positivo
			print("Resultado positivo, siguiente parte: ", dialogoParte)
		else: 
			dialogoParte = dialogo[str(dialogoParte)].resultados.negativo
			print("Resultado negativo, siguiente parte: ", dialogoParte)
		currLine = 0
		loadLines(dialogoParte)


func nextLine():
	print("Parte: ", dialogoParte)
	if(dialogo.size() < 1):
		return
	if(currLine >= lineas.size()):
		# Suma 1 a la parte del dialogo
		dialogoParte += 1
		# Condicionales
		if(dialogo[str(dialogoParte)].has('conditional')):
			if(!sceneManager.condicionales.has(dialogo[str(dialogoParte)].conditional)):
				return
		# Recompensas
		if(dialogo[str(dialogoParte)].has('reward')):
			sceneManager.condicionales.append(dialogo[str(dialogoParte)].reward)
		if(dialogo[str(dialogoParte)].tipo == "dialogo"):
			# Reinicia las lineas
			currLine = 0
			# Toma las lineas de la nueva parte
			loadLines(dialogoParte)
		if(dialogo[str(dialogoParte)].tipo == "flores"):
			sceneManager.changeToFlowers(dialogo[str(dialogoParte)].requisitos);
			currLine = 0
			return
		if(dialogo[str(dialogoParte)].tipo == "jump"):
			# Salta a uno antes del seleccionado
			dialogoParte = dialogo[str(dialogoParte)].parte-1
			return
		if(dialogo[str(dialogoParte)].tipo == "retake"):
			dialogoParte = dialogo[str(dialogoParte)].parte
			sceneManager.changeToFlowers(dialogo[str(dialogoParte)].requisitos);
			return
		if(dialogo[str(dialogoParte)].tipo == "sonido"):
			audioPlayer.stream = load(dialogo[str(dialogoParte)].source)
			audioPlayer.play()
			# Reinicia las lineas
			currLine = 0
			# Toma las lineas de la nueva parte
			loadLines(dialogoParte)
			return
		if(dialogo[str(dialogoParte)].tipo == "fin"):
			if(dialogo[str(dialogoParte)].has('jump')):
				# salta a el cliente -1 para sumarlo despues
				sceneManager.cliente = dialogo[str(dialogoParte)].jump - 1
			# Pasa al siguiente cliente
			lineas = []
			dialogoParte = -1
			dialogeText.text = ""
			nombre.text = ""
			sceneManager.endDialog()
			return
	else:
		dialogeText.text = ""
		writeLine()
		# Animator
		if(dialogo[str(dialogoParte)].hablante == "cliente"):
			cliente.clientHabla()
			nombre.text = Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].nombre
			speakingPlayer.stream = load(Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].tone)
			# Comprueba que tenga sprites alternativos
			if(Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].altSprite):
				cliente.changeSprite(Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].altSprite)
		if(dialogo[str(dialogoParte)].hablante == "tu"):
			nombre.text = "Flora"
			speakingPlayer.stream = load("res://Media/mujer_hablando.ogg")
			# Comprueba que tenga sprites alternativos
			if(Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].altSprite):
				cliente.changeSprite(Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].sprite)
		if(dialogo[str(dialogoParte)].hablante == ""):
			nombre.text = ""


func writeLine():
#	print("Write: ", lineas[currLine])
	escribiendo = true
	for letter in lineas[currLine]:
		# pausa cada almohadilla
		if(letter == "#"):
			yield(get_tree().create_timer(0.5), "timeout")
			# elimina el simbolo del texto
		else:
			dialogeText.text += letter
			speakingPlayer.play()
			yield(get_tree().create_timer(waiting), "timeout")
	# Termina de escribir
	currLine += 1
	escribiendo = false
