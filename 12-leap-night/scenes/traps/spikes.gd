extends Area2D

func _on_body_entered(_body: Node2D) -> void:
	SoundManager.play_impact()
	EventManager.on_player_dead.emit()
