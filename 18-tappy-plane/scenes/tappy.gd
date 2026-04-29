extends CharacterBody2D
class_name Tappy

const JUMP_FORCE : float = -350.0
var _gravity : float = 980.0 #physics/2d/default_gravity
var _jumped : bool = false

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_jumped = true
	else:
		_jumped = false

func _physics_process(delta: float) -> void:
	fly(delta)
	move_and_slide()
	
	if is_on_floor():
		print("is_on_floor")
		die()
	if is_on_ceiling():
		print("is_on_ceiling")

func fly(delta: float) -> void:
	velocity.y += _gravity * delta
	#if _jumped:
	#	velocity.y = JUMP_FORCE
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE
		animation_player.play("thrust")

func die() -> void:
	#animated_sprite_2d.stop()
	#set_physics_process(false)
	get_tree().paused = true
	SignalHub.emit_on_plane_died()
