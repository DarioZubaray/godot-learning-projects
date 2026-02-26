extends Control
class_name CookBar

signal on_cook_completed

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

func cook_item(timer: float) -> void:
	var tween := create_tween()
	tween.tween_property(texture_progress_bar, "value", 1.0, timer)
	tween.finished.connect(func(): on_cook_completed.emit())

func reset_bar() -> void:
	texture_progress_bar.value = 0
