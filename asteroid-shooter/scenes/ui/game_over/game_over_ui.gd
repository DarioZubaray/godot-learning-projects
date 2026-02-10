extends Control

@onready var score_label: Label = %ScoreLabel

func _process(delta: float) -> void:
	if GameManager.is_game_over:
		visible = true
		score_label.text = "Your score: " + str(GameManager.score)
	
