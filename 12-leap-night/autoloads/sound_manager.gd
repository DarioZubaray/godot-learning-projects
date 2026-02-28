extends Node

const FRUIT = preload("uid://b7ongpxc57bgh")
const HIT = preload("uid://7ltefi2u76cw")
const JUMPING_SFX = preload("uid://gw1h6skpmido")

@onready var sfx_streams: Node = $SFXStreams

func play_fruit() -> void:
	play_audio(FRUIT)

func play_impact() -> void:
	play_audio(HIT)

func play_jump() -> void:
	play_audio(JUMPING_SFX)

func play_audio(audio: AudioStream) -> void:
	var audio_stream := get_free_stream()
	audio_stream.stream = audio
	audio_stream.play()

func get_free_stream() -> AudioStreamPlayer:
	for stream: AudioStreamPlayer in sfx_streams.get_children():
		if not stream.playing:
			return stream
	
	return null
