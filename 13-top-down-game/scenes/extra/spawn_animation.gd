extends Sprite2D
class_name SpawnAnimation

signal on_spawn_enemy

func spawn_enemy() -> void:
	on_spawn_enemy.emit()
