extends Area2D

@export var points: int
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

func _on_area_entered(_area: Area2D) -> void:
	GameManager.update_score(points)
	SignalManager.emit_signal("score_updated")
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.PICKUP)
	timer.start()
	visible = false

func _on_timer_timeout() -> void:
	queue_free()
