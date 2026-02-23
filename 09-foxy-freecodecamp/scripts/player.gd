extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

const MAX_JUMPS := 2
var jumps_left := MAX_JUMPS

const ROLL_SPEED := 500.0
const ROLL_TIME := 0.35

var roll_timer := 0.0
var roll_direction := 1

enum PlayerState {
	IDLE,
	RUN,
	JUMP,
	FALL,
	CROUCH,
	DIZZY,
	LOOKUP,
	ROLL,
	VICTORY
}

var state: PlayerState = PlayerState.IDLE

func _physics_process(delta: float) -> void:
	add_gravety(delta)
	jump()
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	flip(direction)
	if Input.is_action_just_pressed("roll"):
		try_start_roll(direction)
	move(direction, delta)
	move_and_slide()
	if is_on_floor():
		jumps_left = MAX_JUMPS
	handle_state_input()
	update_animation(direction)
	check_health()

func add_gravety(delta: float) -> void:
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta

func jump() -> void:
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1
		animated_sprite.play("jump")

func flip(direction: float) -> void:
	if direction == -1:
		animated_sprite.flip_h = true
	elif direction == 1:
		animated_sprite.flip_h = false

func try_start_roll(direction: float):
	if state != PlayerState.ROLL and is_on_floor():
		state = PlayerState.ROLL
		roll_timer = ROLL_TIME
		@warning_ignore("narrowing_conversion")
		roll_direction = direction if direction != 0.0 else (1.0 if !animated_sprite.flip_h else -1.0)

func move(direction: float, delta: float) -> void:
	match state:
		PlayerState.ROLL:
			velocity.x = roll_direction * ROLL_SPEED
			velocity.y = 0
			roll_timer -= delta
			if roll_timer <= 0:
				state = PlayerState.IDLE
		_:
			if direction:
				velocity.x = direction * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_state_input():
	if Input.is_action_just_pressed("crouch"):
		state = PlayerState.CROUCH
	elif Input.is_action_just_pressed("dizzy"):
		state = PlayerState.DIZZY
	elif Input.is_action_just_pressed("lookup"):
		state = PlayerState.LOOKUP
	elif Input.is_action_just_pressed("roll"):
		state = PlayerState.ROLL
	elif Input.is_action_just_pressed("victory"):
		state = PlayerState.VICTORY

func update_animation(direction: float) -> void:
	match state:
		PlayerState.CROUCH:
			play_animation("crouch")
		PlayerState.DIZZY:
			play_animation("dizzy")
		PlayerState.LOOKUP:
			play_animation("lookup")
		PlayerState.ROLL:
			velocity.x = direction * SPEED
			play_animation("roll")
		PlayerState.VICTORY:
			play_animation("victory")
		_:
			update_movement_animation(direction)

func update_movement_animation(direction: float):
	if not is_on_floor():
		if velocity.y < 0:
			play_animation("jump")
		else:
			play_animation("fall")
	else:
		if direction != 0:
			play_animation("run")
		else:
			play_animation("idle")

func play_animation(animation_name: String) -> void:
	if animated_sprite.animation == animation_name:
		return
	animated_sprite.play(animation_name)

func _on_animated_sprite_2d_animation_finished() -> void:
	state = PlayerState.IDLE

func check_health() -> void:
	if GameManager.playerHP <= 0:
		set_physics_process(false)
		play_animation("dizzy")
		await animated_sprite.animation_finished
		queue_free()
		get_tree().change_scene_to_file("res://scenes/main.tscn")
