extends Control

@onready var v_box_container: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer

func _ready() -> void:
	var level_launches = GameManager.levels_launches
	for level in level_launches:
		var label = Label.new()
		label.text = "Level " + str(level) + ": " + str(level_launches[level])
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		v_box_container.add_child(label)
	
	var button = Button.new()
	button.text = "Go Back"
	v_box_container.add_child(button)
	button.pressed.connect(on_button_pressed)

func on_button_pressed() -> void:
	GameManager.reset_game()
