extends CharacterBody2D

@export var speed: float
@export var jump_speed: float
@export var gravity: float

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var is_facing_right = true

func _ready() -> void:
	SignalManager.level_completed.connect(on_level_completed)

func _physics_process(delta: float) -> void:
	jump(delta)
	move_x()
	flip()
	update_animations()
	move_and_slide()

func update_animations() -> void:
	if is_on_floor():
		if velocity.x != 0:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
	else:
		if velocity.y < 0:
			animated_sprite_2d.play("jump")
		else:
			animated_sprite_2d.play("fall")

func jump(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed
		AudioManager.play_sfx(audio_stream_player_2d, AudioManager.JUMP)
	if not is_on_floor():
		velocity.y += gravity * delta

func move_x() -> void:
	var input_axis := Input.get_axis("left", "right")
	velocity.x = input_axis * speed

func flip() -> void:
	if (is_facing_right and velocity.x < 0) or (not is_facing_right and velocity.x > 0):
		scale.x *= -1
		is_facing_right = not is_facing_right

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if not area.is_in_group("traps") and position.y < area.global_position.y:
		velocity.y = -jump_speed
	else:
		dead()

func dead() -> void:
	set_physics_process(false)
	animated_sprite_2d.pause()
	animation_player.play("dead")
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.PLAYER_DIE)

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
	GameManager.restart_level()

func on_level_completed() -> void:
	set_physics_process(false)
	animated_sprite_2d.play("idle")
