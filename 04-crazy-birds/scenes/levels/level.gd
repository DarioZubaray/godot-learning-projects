extends Node2D

@onready var enemies: Node2D = $Enemies


func _ready() -> void:
	var total_enemies = enemies.get_child_count()
	GameManager.set_enemies_left(total_enemies)
