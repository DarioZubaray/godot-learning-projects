extends Button

func _ready() -> void:
	pressed.connect(_salir)

func _salir() -> void:
	get_tree().quit()
