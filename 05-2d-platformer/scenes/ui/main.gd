extends Control

@onready var start_button: Button = $VBoxContainer/StartButton
@onready var high_score_label: Label = $VBoxContainer/HighScoreLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sfx_button: Button = $VBoxContainer/SFXButton
@onready var music_button: Button = $VBoxContainer/MusicButton

func _ready() -> void:
	AudioManager.restart_audio()
	start_button.grab_focus()
	high_score_label.text = "High Score: " + str(GameManager.high_score)

func _on_start_button_pressed() -> void:
	GameManager.load_next_level()

func _on_button_focus_entered() -> void:
	AudioManager.play_sfx(audio_stream_player_2d, AudioManager.BUTTON_FOCUS)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_sfx_button_pressed() -> void:
	AudioManager.toggle_sfx()
	if AudioManager.is_sfx_active:
		sfx_button.text = "SFX: on"
	else:
		sfx_button.text = "SFX: off"

func _on_music_button_pressed() -> void:
	AudioManager.toggle_music()
	if AudioManager.is_music_active:
		music_button.text = "Music: on"
	else:
		music_button.text = "Music: off"
