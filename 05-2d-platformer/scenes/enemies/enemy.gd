class_name Enemy

extends CharacterBody2D

@export var speed: float
@export var gravity : float
@export var points: int
@onready var hurtbox: Area2D = $Hurtbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var player 

func _ready() -> void:
	SignalManager.level_completed.connect(on_level_completed)
	_setup()

func _setup() -> void:
	player = get_tree().get_first_node_in_group("player")
	set_physics_process(false)


func _on_hurtbox_area_entered(_area: Area2D) -> void:
	if player.position.y < hurtbox.global_position.y:
		die()
	else:
		print("jaja te mataron sonso")

func die() -> void:
	animation_player.play("dessapear")
	set_physics_process(false)
	animated_sprite_2d.pause()
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.ENEMY_DIE)
	GameManager.update_score(points)
	SignalManager.emit_signal("score_updated")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	set_physics_process(true)

func on_level_completed() -> void:
	set_physics_process(false)
	animated_sprite_2d.pause()
