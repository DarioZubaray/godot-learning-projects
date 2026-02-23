extends Control

func _ready() -> void:
	UtilityManager.save_game()
	UtilityManager.load_game()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")
