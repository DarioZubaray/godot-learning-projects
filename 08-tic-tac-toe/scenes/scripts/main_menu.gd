extends Control

@onready var play_button: Button = $VBoxContainer/PlayButton
@onready var exit_button: Button = $VBoxContainer/ExitButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	animation_player.play("fade_out")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_exit_pressed():
	get_tree().quit()
