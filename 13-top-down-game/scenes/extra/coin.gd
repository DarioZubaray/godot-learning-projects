extends Area2D
class_name Coin

@export var coin_value := 1
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _on_body_entered(_body: Node2D) -> void:
	GameManager.coins += coin_value
	audio_stream_player.play()
	
	await audio_stream_player.finished
	
	queue_free()
