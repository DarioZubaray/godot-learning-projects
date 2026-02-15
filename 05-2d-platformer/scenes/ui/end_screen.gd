extends Control

@onready var end_label: Label = $PanelContainer/MarginContainer/VBoxContainer/EndLabel
@onready var score_label: Label = $PanelContainer/MarginContainer/VBoxContainer/ScoreLabel
@onready var return_button: Button = $PanelContainer/MarginContainer/VBoxContainer/ReturnButton

func _ready() -> void:
	return_button.grab_focus()
	update_end_label()

func update_end_label() -> void:
	if GameManager.lives <= 0:
		end_label.text = "GAME OVER"
	else:
		end_label.text = "Congratulations!"
	
	score_label.text = "Your Score: " + str(GameManager.score)

func _on_return_button_pressed() -> void:
	GameManager.restart_game()
