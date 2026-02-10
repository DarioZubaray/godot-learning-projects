extends Node2D

@export var power_up: PackedScene

@export var min_x: float
var max_x: float
@export var min_y: float
var max_y: float

@onready var timer: Timer = $Timer

func _ready() -> void:
	print(get_viewport().size)
	max_x = get_viewport().size.x / 2
	max_y = get_viewport().size.y

func create_power_up() -> void:
	print("creando power up")
	var power_up_instance = power_up.instantiate()
	
	add_child(power_up_instance)
	var random_x = randf_range(min_x, max_x)
	var random_y = randf_range(min_y, max_y)
	power_up_instance.global_position.x = random_x
	power_up_instance.global_position.y = random_y
	
	print("creando power up en: " + str(random_x) + ", " + str(random_y))

func _on_timer_timeout() -> void:
	if GameManager.is_game_over:
		timer.stop()
		return
	
	create_power_up()
