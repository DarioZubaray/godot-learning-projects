extends CharacterBody2D
class_name EnemyBlueBird

@export var path: CustomPathFollow

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var bird_dead := false
var player_dead := false

func _process(_delta: float) -> void:
	animated_sprite.flip_h = path.direction == 1

func _on_top_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	if player_dead:
		return
	
	path.can_move = false
	bird_dead = true
	animated_sprite.play("hit")
	body.velocity.y = -250
	SoundManager.play_impact()
	await animated_sprite.animation_finished
	queue_free()

func _on_bottom_area_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	if bird_dead:
		return
	
	player_dead = true
	SoundManager.play_impact()
	EventManager.on_player_dead.emit()
