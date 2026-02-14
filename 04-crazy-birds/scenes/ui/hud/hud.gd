extends Control

@onready var launches_label: Label = $MarginContainer/LaunchesLabel
@onready var level_completed_label: Label = $MarginContainer/LevelCompletedLabel

func _ready() -> void:
	SignalManager.player_launched.connect(on_player_launched)
	SignalManager.level_completed.connect(on_level_completed)

func on_player_launched() -> void:
	print("Pajaro lanzado")
	launches_label.text = "Launches: " + str(GameManager.launches)
	
func on_level_completed() -> void:
	print("Level completed!")
	level_completed_label.visible = true
