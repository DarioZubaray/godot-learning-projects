extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.gold += 5
		
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween1.tween_property(self, "position", position - Vector2(0, 35), 0.35)
		tween2.tween_property(self, "modulate:a", 0, 0.3)
		tween1.tween_callback(queue_free)
