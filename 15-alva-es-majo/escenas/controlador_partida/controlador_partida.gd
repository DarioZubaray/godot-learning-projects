extends Node
class_name ControladorPartida

@export var partida: DatosPartida

const RUTA: String = "user://partida.tres"

func guardar_partida() -> void:
	partida.nivel = ControladorGlobal.nivel
	partida.muertes = ControladorGlobal.muertes
	
	ResourceSaver.save(partida, RUTA)

func cargar_partida() -> void:
	if ResourceLoader.exists(RUTA):
		partida = load(RUTA)
	
	ControladorGlobal.nivel = partida.nivel
	ControladorGlobal.muertes = partida.muertes
