extends Node

@onready var score_label: Label = $CanvasLayer/ScoreLabel
@onready var level_label: Label = $CanvasLayer/LevelLabel

var score := 0
var level := 1

func _process(_delta: float) -> void:
	score_label.text = "Points: %d" % score
	level_label.text = "Level: %d" % level

func add_points(points: int) -> void:
	score += points
