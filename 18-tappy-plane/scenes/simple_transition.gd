extends Control

func _ready() -> void:
	await get_tree().create_timer(0.75).timeout
	GameManager.change_to_next_scene()
