extends AnimatableBody2D

@export var target: Marker2D
@export var duration: float

var tween: Tween

func _ready() -> void:
	var start_position = position
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position", target.global_position, duration)
	tween.tween_property(self, "position", start_position, duration)
	tween.set_loops()


func _on_tree_exited() -> void:
	tween.kill()
