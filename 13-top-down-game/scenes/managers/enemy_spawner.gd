extends Node
class_name EnemySpawner

signal on_wave_completed

const SPAWN_ANIMATION = preload("uid://c386q25a3qolv")

enum SpawnType {
	RandomTimer,
	FixedTimer
}

@export var spawn_type: SpawnType
@export var min_random: float
@export var max_random: float
@export var fixed_timer: float
@export var enemies_per_wave := 5

@export var enemy_list: Array[PackedScene] = []

@onready var timer: Timer = $Timer

var enemies_remaining: int
var spawned_enemies: int

func _ready() -> void:
	GameManager.on_enemy_died.connect(_on_enemy_died)
	enemies_remaining = enemies_per_wave

func spawn_enemy() -> void:
	var spawn_anim: SpawnAnimation = SPAWN_ANIMATION.instantiate()
	var position_x = randf_range(-1000, 1000)
	var position_y = randf_range(-1000, 1000)
	var spawn_position = Vector2(position_x, position_y)
	spawn_anim.global_position = spawn_position
	add_child(spawn_anim)
	
	await spawn_anim.on_spawn_enemy
	spawn_anim.queue_free()
	
	var random_enemy = enemy_list.pick_random()
	var enemy = random_enemy.instantiate() as Enemy
	enemy.global_position = spawn_position
	add_child(enemy)
	
	spawned_enemies += 1
	start_enemy_timer()

func start_enemy_timer() -> void:
	timer.wait_time = get_new_timer()
	timer.start()

func get_new_timer() -> float:
	var time: float
	
	if spawn_type == SpawnType.RandomTimer:
		time = randf_range(min_random, max_random)
	else:
		time = fixed_timer
	
	return time


func _on_timer_timeout() -> void:
	if spawned_enemies >= enemies_per_wave:
		return
	
	spawn_enemy()

func _on_enemy_died() -> void:
	enemies_remaining -= 1
	if enemies_remaining <= 0:
		timer.stop()
		on_wave_completed.emit()
		enemies_remaining = enemies_per_wave
		spawned_enemies = 0
