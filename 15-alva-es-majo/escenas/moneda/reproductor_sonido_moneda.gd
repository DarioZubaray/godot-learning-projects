extends AudioStreamPlayer2D

func _ready() -> void:
	finished.connect(_eliminar)

func _eliminar() -> void:
	queue_free()
