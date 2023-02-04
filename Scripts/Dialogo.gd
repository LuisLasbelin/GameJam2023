extends Control


onready var dialogeText = $RichTextLabel
onready var sceneManager = $"../SceneManager"


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
	loadDialog(sceneManager.dia, sceneManager.cliente)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func writeLine():
	print("Write: ", dialogeText.text)
	escribiendo = true
	for letter in dialogeText.text:
		dialogeText.visible_characters += 1
		yield(get_tree().create_timer(waiting), "timeout")
	# Termina de escribir
	currLine += 1
	escribiendo = false


func _on_Button_pressed():
	if(!escribiendo):
		nextLine()


func loadDialog(dia, cliente):
	dialogo = Escena1.scenedata.dias[str(dia)].clientes[str(cliente)].dialogo
	loadLines(dialogoParte)


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
		nextLine()


func nextLine():
	print("Linea: ", currLine)
	dialogeText.visible_characters = 0
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
		dialogeText.text = lineas[currLine]
		writeLine()
