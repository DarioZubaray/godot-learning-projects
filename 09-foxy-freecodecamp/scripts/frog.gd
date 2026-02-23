extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var main_collision_shape: CollisionShape2D = $MainCollisionShape2D
@onready var hurtbox_collision_shape: CollisionShape2D = $Hurtbox/HurtboxCollisionShape2D
@onready var hitbox_collision_shape: CollisionShape2D = $Hitbox/HitboxCollisionShape2D

var SPEED = 50
var player: Node
var chasing = false

func _ready() -> void:
	animated_sprite.play("idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	chase_player()
	move_and_slide()

func chase_player() -> void:
	if chasing:
		animated_sprite.play("jump")
		player = get_node("../../Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
		
		velocity.x = direction.x * SPEED
	else:
		animated_sprite.play("idle")
		velocity.x = 0

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chasing = true

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chasing = false

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		death()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.playerHP -= 3
		UtilityManager.save_game()
		death()

func death() -> void:
	GameManager.gold += 5
	UtilityManager.save_game()
	chasing = false

	main_collision_shape.set_deferred("disabled", true)
	hitbox_collision_shape.set_deferred("disabled", true)
	hurtbox_collision_shape.set_deferred("disabled", true)

	set_physics_process(false)
	animated_sprite.play("death")

	await animated_sprite.animation_finished
	queue_free()
