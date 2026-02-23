extends Node

const SAVE_PATH = "res://savegame.bin"

func save_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": GameManager.playerHP,
		"gold": GameManager.gold,
	}
	var jsonStr = JSON.stringify(data)
	file.store_line(jsonStr)
	

func load_game() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				GameManager.playerHP = current_line["playerHP"]
				GameManager.gold = current_line["gold"]
