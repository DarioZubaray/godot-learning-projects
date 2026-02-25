extends Node
class_name Spawner

signal on_obstacle_crash
signal on_player_score

const OBSTACLE_SCENE = preload("uid://c7fvnll8lcwhe")

@onready var timer: Timer = $Timer

func spawn_obstacle() -> void:
	var obstacle_instance: Obstacle = OBSTACLE_SCENE.instantiate()
	obstacle_instance.on_player_crashed.connect(on_player_crashed)
	obstacle_instance.on_player_scored.connect(on_player_scored)
	
	var viewport: Viewport = get_viewport()
	obstacle_instance.position.x = viewport.get_visible_rect().end.x + 150
	
	var half_height = viewport.size.y / 2
	obstacle_instance.position.y = randf_range(half_height + 300, half_height - 50)
	
	add_child(obstacle_instance)

func _on_timer_timeout() -> void:
	spawn_obstacle()

func stop_obstacles() -> void:
	timer.stop()
	
	var all_obstacles = get_children().filter(func(x): return x is Obstacle)
	for obs: Obstacle in all_obstacles:
		obs.set_speed(0)

func on_player_crashed() -> void:
	on_obstacle_crash.emit()
	stop_obstacles()

func on_player_scored() -> void:
	on_player_score.emit()
