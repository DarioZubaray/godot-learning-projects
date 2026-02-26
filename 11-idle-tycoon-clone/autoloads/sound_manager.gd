extends Node

const COINS = preload("uid://ddcg8qn43j1k2")
const NORMAL_SFX = preload("uid://bnm1pbwytu7pc")

@export var stream_players: Array[AudioStreamPlayer]

func get_free_audio_player() -> AudioStreamPlayer:
	for audio: AudioStreamPlayer in stream_players:
		if not audio.playing:
			return audio
	return null

func play_audio(clip: AudioStream, volumen: float) -> void:
	var free_player = get_free_audio_player()
	if free_player:
		free_player.stream = clip
		free_player.volume_db = volumen
		free_player.play()

func play_coins() -> void:
	play_audio(COINS, -5.0)

func play_ui() -> void:
	play_audio(NORMAL_SFX, 0.5)
