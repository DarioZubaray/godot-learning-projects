extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	SignalManager.level_completed.connect(on_level_completed)
	animation_player.play("fade_in")
	visible = true

func on_level_completed() -> void:
	animation_player.play("fade_out")
	visible = true

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		GameManager.load_next_level()
