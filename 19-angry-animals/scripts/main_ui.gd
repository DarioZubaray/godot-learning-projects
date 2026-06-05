extends Control

@onready var attemp_label: Label = $MarginContainer/VBoxContainer/HBoxAttempContainer/AttempNumberLabel
@onready var level_completed_label: Label = $CenterContainer/VBoxContainerComplete/LevelCompletedLabel
@onready var press_escape_label: Label = $CenterContainer/VBoxContainerComplete/PressEscapeLabel
@onready var main_music: AudioStreamPlayer = $MainMusic

const MAIN = preload("uid://biu3dfbxq3yw0")

var _total_cups : int = 0
var _current_cups : int = 0
var _attemps : int = -1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_packed(MAIN)

func _ready() -> void:
	get_tree().paused = false
	SignalHub.on_cup_destroy.connect(_on_cup_destroy)
	SignalHub.on_attemp_made.connect(on_attemp_made)
	_total_cups = get_tree().get_nodes_in_group(Cup.GROUP_NAME).size()
	on_attemp_made()

func _on_cup_destroy() -> void:
	_current_cups += 1
	print("current cups: " + str(_current_cups))
	
	if _current_cups == _total_cups:
		main_music.play()
		show_game_complete()
		ScoreManager.set_score_for_scurrent_level(_attemps)
		get_tree().paused = true

func on_attemp_made() -> void:
	_attemps += 1
	attemp_label.text = "%d" % _attemps

func show_game_complete() -> void:
	level_completed_label.show()
	press_escape_label.show()
