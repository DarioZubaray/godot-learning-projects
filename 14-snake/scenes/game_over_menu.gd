extends CanvasLayer

signal on_restart_game

func _on_restart_button_pressed() -> void:
	on_restart_game.emit()
