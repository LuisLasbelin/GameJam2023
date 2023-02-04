extends Control


onready var dialogeText = $Label
onready var sceneManager = $"../../SceneManager"
onready var cliente = $"../../Cliente"
onready var nombre = $Nombre


var percText = 0
export var waiting = 0.05
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


func writeLine():
	print("Write: ", lineas[currLine])
	escribiendo = true
	for letter in lineas[currLine]:
		# pausa cada almohadilla
		if(letter == "#"):
			yield(get_tree().create_timer(0.5), "timeout")
			# elimina el simbolo del texto
		else:
			dialogeText.text += letter
			yield(get_tree().create_timer(waiting), "timeout")
	# Termina de escribir
	currLine += 1
	escribiendo = false


func _on_Button_pressed():
	if(!escribiendo):
		nextLine()


func loadDialog():
	dialogo = Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].dialogo
	loadLines(dialogoParte)


# Carga las lineas de la parte enviada y el valor dialogo del script
func loadLines(_part):
	lineas = dialogo[str(_part)].lineas
	# Nombre del hablante
	nombre.text = Escena1.scenedata.dias[str(sceneManager.dia)].clientes[str(sceneManager.cliente)].nombre
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
	print("Linea: ", currLine)
	# Animator
	cliente.clientHabla()
	# Cuando llega a la ultima linea de esta parte
	if(currLine >= lineas.size()):
		# Suma 1 a la parte del dialogo
		dialogoParte += 1
		print("Parte: ", dialogoParte)
		# Si ya ha llegado al final del dialogo, cambia al siguiente cliente
		if(dialogoParte >= dialogo.size()):
			print("NUEVO CLIENTE")
			sceneManager.loadClient(sceneManager.dia, sceneManager.cliente + 1)
		# Si todavia no llega al final del dialogo
		else:
			if(dialogo[str(dialogoParte)].tipo == "dialogo"):
				# Toma las lineas de la nueva parte
				loadLines(dialogoParte)
				# Reinicia las lineas
				currLine = 0
			if(dialogo[str(dialogoParte)].tipo == "flores"):
				sceneManager.changeToFlowers(dialogo[str(dialogoParte)].requisitos);
				currLine = 0
				return
			if(dialogo[str(dialogoParte)].tipo == "fin"):
				# Pasa al siguiente cliente
				sceneManager.cliente += 1
				lineas = []
				sceneManager.endDialog()
				return
	else:
		dialogeText.text = ""
		writeLine()
