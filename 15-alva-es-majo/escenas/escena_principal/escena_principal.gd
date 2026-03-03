extends Node2D

@export var niveles: Array[PackedScene]
@onready var controlador_partida: ControladorPartida = $ControladorPartida

var _nivel_actual: int = 1
var _nivel_instanciado: Node

func _ready() -> void:
	if ControladorGlobal.nivel > 1:
		_cargar_nivel()
	else:
		_crear_nivel(_nivel_actual)

func _crear_nivel(numero_nivel: int) -> void:
	_nivel_instanciado = niveles[numero_nivel - 1].instantiate()
	add_child(_nivel_instanciado)
	
	#var hijos := _nivel_instanciado.get_children()
	#for i in hijos.size():
	#	if hijos[i].is_in_group("personajes"):
	#		hijos[1].personaje_muerto.connect(_reiniciar_nivel)
	#		break
	var personajes := get_tree().get_nodes_in_group("personajes")
	#personajes[0].personaje_muerto.connect(_reiniciar_nivel)
	print("Nodos en el grupo: ", personajes.size()) # Si sale más de 1, aquí está el lío
	for p in personajes:
		print("Personaje: ", p.name, " ID: ", p.get_instance_id(), " Padre: ", p.get_parent().name)
		if not p.personaje_muerto.is_connected(_reiniciar_nivel):
			p.personaje_muerto.connect(_reiniciar_nivel)
			print("¡Conexión exitosa!")
		else:
			print("Ya estaba conectado, ignorando...")
	
	#var p = personajes[0]
	#if not p.personaje_muerto.is_connected(_reiniciar_nivel):
	#	p.personaje_muerto.connect(_reiniciar_nivel)
	
	ControladorGlobal.nivel = numero_nivel
	controlador_partida.guardar_partida()

func _eliminar_nivel() -> void:
	_nivel_instanciado.queue_free()

func _reiniciar_nivel() -> void:
	print("reiniciando el nivel")
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)

func siguiente_nivel() -> void:
	_nivel_actual += 1
	print("siguiente nivel %s" % _nivel_actual)
	_eliminar_nivel()
	_crear_nivel.call_deferred(_nivel_actual)

func _cargar_nivel() -> void:
	_nivel_actual = ControladorGlobal.nivel
	_crear_nivel.call_deferred(_nivel_actual)
