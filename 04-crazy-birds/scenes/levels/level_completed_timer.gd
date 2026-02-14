extends Timer


func _ready() -> void:
	SignalManager.level_completed.connect(on_level_completed)

func on_level_completed() -> void:
	start()


func _on_timeout() -> void:
	GameManager.load_next_level()
