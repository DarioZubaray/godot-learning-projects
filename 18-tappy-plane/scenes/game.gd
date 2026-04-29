extends Node

const PIPES = preload("uid://dmey1vh8hkkdc")

@onready var pipe_holder: Node = $PipeHolder
@onready var upper_spawn_marker: Marker2D = $UpperSpawnMarker
@onready var lower_spawn_marker: Marker2D = $LowerSpawnMarker

func _ready() -> void:
	spawn_pipe()

func spawn_pipe() -> void:
	var new_pipe = PIPES.instantiate()
	var random_y_position = randf_range(upper_spawn_marker.position.y, lower_spawn_marker.position.y)
	new_pipe.position = Vector2(upper_spawn_marker.position.x, random_y_position)
	pipe_holder.add_child(new_pipe)

func _on_spawn_timer_timeout() -> void:
	spawn_pipe()
