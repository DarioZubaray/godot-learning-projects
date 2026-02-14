extends Marker2D

signal player_spawned(player_instance: Node)

# referencia a escena dinamica
@export var player_scene : PackedScene
# referencia a escena fija
const PLAYER = preload("uid://kv8xodshjf0n")

var can_spawn = true

func _ready() -> void:
	SignalManager.level_completed.connect(on_level_completed)
	create_player()

func create_player() -> void:
	if can_spawn:
		var player_instance = player_scene.instantiate()
		add_sibling.call_deferred(player_instance)
		player_instance.position = position
		player_instance.tree_exited.connect(on_player_tree_exited)
		player_spawned.emit(player_instance)

func on_player_tree_exited() -> void:
	create_player()

func on_level_completed() -> void:
	can_spawn = false
