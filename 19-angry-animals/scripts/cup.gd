class_name Cup
extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const GROUP_NAME : String = "Cup"

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func die() -> void:
	animation_player.play("vanish")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	SignalHub.emit_on_cup_destroy()
	queue_free()
