extends Node2D

@onready var start_marker_2d: Marker2D = $StartMarker2D
const ANIMAL = preload("uid://fw2n1qsjfs1v")

func _ready() -> void:
	SignalHub.animal_die.connect(on_animal_die)
	spawn_animal()

func spawn_animal() -> void:
	var animal_scene := ANIMAL.instantiate()
	animal_scene.global_position = start_marker_2d.position
	call_deferred("add_child", animal_scene)

func on_animal_die() -> void:
	spawn_animal()
