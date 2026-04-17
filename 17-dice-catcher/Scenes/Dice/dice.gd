extends Area2D
class_name Dice

signal game_over

const SPEED := 80.0
const ROTATION_SPEED := 5.0
var rotation_direction := 1.0

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	if randf() < 0.5:
		rotation_direction *= -1

func _physics_process(delta: float) -> void:
	position.y += SPEED * delta
	sprite_2d.rotate(ROTATION_SPEED * delta)
	check_game_over()

func check_game_over() -> void:
	if get_viewport_rect().end.y < position.y:
		print("Off screen")
		set_physics_process(false)
		game_over.emit()
		queue_free()
