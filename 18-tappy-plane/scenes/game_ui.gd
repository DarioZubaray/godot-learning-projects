extends Control

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $Timer

var is_plane_died := false
var _score := 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		GameManager.load_main_scene()
	if is_plane_died and event.is_action_pressed("jump"):   
		GameManager.load_main_scene()

func _ready() -> void:
	SignalHub.on_plane_died.connect(_on_plane_died)
	SignalHub.on_point_scored.connect(_on_point_scored)

func _on_plane_died() -> void:
	game_over_label.show()
	audio_stream_player.play()
	# await get_tree().create_timer(2.0).timeout
	timer.start()
	HighscoreManager.high_score = _score

func _on_timer_timeout() -> void:
	is_plane_died = true
	game_over_label.hide()
	press_space_label.show()

func _on_point_scored() -> void:
	_score += 1
	score_label.text = "%03d" % _score
