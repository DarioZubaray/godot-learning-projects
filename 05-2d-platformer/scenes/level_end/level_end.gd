extends Area2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_area_entered(_area: Area2D) -> void:
	#GameManager.load_next_level()
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.SUCCESS)
	SignalManager.level_completed.emit()
