extends Button

func _on_pressed() -> void:
	print("presiondo")
	GameManager.load_next_level()
