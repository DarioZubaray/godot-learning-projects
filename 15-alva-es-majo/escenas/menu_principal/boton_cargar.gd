extends Button

@onready var controlador_partida: ControladorPartida = $"../../ControladorPartida"
@onready var jugar: Button = $"../Jugar"

func _ready() -> void:
	pressed.connect(_cargar)

func _cargar() -> void:
	controlador_partida.cargar_partida()
	jugar.jugar()
