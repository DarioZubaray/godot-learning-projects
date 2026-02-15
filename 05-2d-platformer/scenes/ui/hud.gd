extends Control

@onready var lives_label: Label = $MarginContainer/LivesLabel
@onready var score_label: Label = $MarginContainer/ScoreLabel

func _ready() -> void:
	SignalManager.score_updated.connect(on_score_updated)
	lives_label.text = "Lives: " + str(GameManager.lives)
	on_score_updated()

func on_score_updated() -> void:
	score_label.text = "Score: " + str(GameManager.score)
	
