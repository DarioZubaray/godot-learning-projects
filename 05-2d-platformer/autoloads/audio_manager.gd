extends Node

const BIT_BIT_LOOP = preload("uid://qhg1ur38bfxa")

const BUTTON_FOCUS = preload("uid://bicy8b7e43xlf")
const ENEMY_DIE = preload("uid://cyfwrdtujgrfu")
const JUMP = preload("uid://b0s6xblqa3m4w")
const PICKUP = preload("uid://cnt4th4mpdqfg")
const PLAYER_DIE = preload("uid://c6x05irw6gq2w")
const SUCCESS = preload("uid://b2x1eewv6kkrc")

var is_sfx_active = true
var is_music_active = true

func play_sfx(audio_stream_player: AudioStreamPlayer2D, sfx: AudioStream) -> void:
	if is_sfx_active:
		audio_stream_player.stream = sfx
		audio_stream_player.play()

func toggle_sfx() -> void:
	is_sfx_active = not is_sfx_active

func play_music(audio_stream_player: AudioStreamPlayer, music: AudioStream) -> void:
	if is_music_active:
		audio_stream_player.stream = music
		audio_stream_player.play()

func toggle_music() -> void:
	is_music_active = not is_music_active

func restart_audio() -> void:
	is_sfx_active = true
	is_music_active = true
