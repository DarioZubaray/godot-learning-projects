extends Marker2D

@export var asteroids: Array[PackedScene]

@export var min_y: float
@export var max_y: float

@onready var timer: Timer = $Timer

func create_asteroid():
	var random_asteroid_scene = asteroids.pick_random()
	var asteroid_instance = random_asteroid_scene.instantiate()
	add_child(asteroid_instance)
	var random_y = randf_range(min_y, max_y)
	asteroid_instance.global_position.y = random_y

func _on_timer_timeout() -> void:
	if GameManager.is_game_over:
		timer.stop()
	create_asteroid()
