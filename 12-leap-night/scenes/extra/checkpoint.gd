extends Area2D
class_name Checkpoint

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	
	animated_sprite.play("reached")
	EventManager.on_checkpoint_reached.emit()
