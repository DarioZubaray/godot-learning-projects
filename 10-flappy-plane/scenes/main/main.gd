extends Node2D

const SAVE_FILE: String = "user://score.save"

@onready var spawner: Spawner = $Spawner
@onready var player: Player = $Player
@onready var game_ui: GameUI = $GameUI

var score: int = 0
var high_score: int

func _ready() -> void:
	load_highscore()

func save_highscore() -> void:
	if score > high_score:
		high_score = score
		var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
		file.store_32(high_score)

func load_highscore() -> void:
	#if FileAccess.file_exists(SAVE_FILE):
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	if file:
		high_score = file.get_32()

func _on_player_on_game_started() -> void:
	print("Empezo el juego")
	spawner.timer.start()
	game_ui.start_menu.hide()

func _on_spawner_on_obstacle_crash() -> void:
	player.stop_movement()

func _on_ground_on_player_crash() -> void:
	spawner.stop_obstacles()
	game_ui.calculte_score(score, high_score)
	game_ui.game_over()

func _on_spawner_on_player_score() -> void:
	score += 1
	game_ui.update_score(score)
	save_highscore()
