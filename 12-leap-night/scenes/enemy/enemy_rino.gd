extends CharacterBody2D
class_name EnemyRino

@export var ray_length := 165.0
@export var move_speed := 50.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wall_ray_cast: RayCast2D = $WallRayCast
@onready var player_ray_cast: RayCast2D = $PlayerRayCast

var direction := 1
var can_move := false
var defeated := false

func _ready() -> void:
	player_ray_cast.target_position.x = ray_length

func _process(_delta: float) -> void:
	if player_ray_cast.is_colliding():
		can_move = true
	
	if can_move:
		velocity.x = direction * move_speed
		animated_sprite.play("run")
		move_and_slide()
	
	if wall_ray_cast.is_colliding():
		can_move = false
		direction *= -1
		animated_sprite.play("hit_wall")
		await get_tree().create_timer(0.8).timeout
		rotate_rino()
		animated_sprite.play("idle")

func rotate_rino() -> void:
	animated_sprite.scale.x = direction
	wall_ray_cast.scale.x = direction
	player_ray_cast.scale.x = direction

func _on_top_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	can_move = false
	defeated = true
	animated_sprite.play("hit")
	SoundManager.play_impact()
	await get_tree().create_timer(1.2).timeout
	queue_free()


func _on_bottom_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	if defeated:
		return
	
	SoundManager.play_impact()
	EventManager.on_player_dead.emit()
