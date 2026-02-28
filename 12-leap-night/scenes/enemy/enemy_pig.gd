extends CharacterBody2D
class_name EnemyPig

@export var move_speed := 80

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast: RayCast2D = $RayCast2D

var direction := 1
var can_move := true
var defeated := false

func _process(_delta: float) -> void:
	if can_move:
		velocity.x = move_speed * direction
		move_and_slide()
	
	if not ray_cast.is_colliding():
		direction *= -1
		animated_sprite.scale.x = direction
		ray_cast.scale.x = direction

func _on_top_area_body_entered(body: Node2D) -> void:
	if not body is Player: return
	can_move = false
	defeated = true
	body.velocity.y = -250
	animated_sprite.play("hit")
	SoundManager.play_impact()
	await get_tree().create_timer(0.5).timeout
	queue_free()

func _on_bottom_area_body_entered(body: Node2D) -> void:
	if not body is Player: return
	if defeated: return
	SoundManager.play_impact()
	EventManager.on_played_dead.emit()
