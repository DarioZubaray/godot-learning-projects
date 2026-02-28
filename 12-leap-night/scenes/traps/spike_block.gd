extends StaticBody2D
class_name SpikeBlock

@export var rotation_interval := 2.0

@onready var visuals: Node2D = $Visuals

var timer: float

func _process(delta: float) -> void:
	timer += delta
	if timer >= rotation_interval:
		do_rotation()
		timer = 0.0

func do_rotation() -> void:
	var current_rotation := visuals.rotation_degrees
	var desired_rotation := current_rotation - 90
	
	var tween := create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(visuals, "rotation_degrees", desired_rotation, 0.5)
