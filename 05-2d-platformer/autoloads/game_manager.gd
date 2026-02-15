extends Node

var current_level = 0
var lives = 3
var score = 0
var high_score = 0

const SAVE_FILE_PATH = "user://savefile.save"

func _ready() -> void:
	load_high_score()

func update_score(points) -> void:
	score += points

func save_high_score() -> void:
	if score > high_score:
		high_score = score
		var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
		save_file.store_32(high_score)

func load_high_score() -> void:
	if FileAccess.file_exists(SAVE_FILE_PATH):
		var save_file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		high_score = save_file.get_32()

var LEVELS = {
	0: preload("res://scenes/ui/main.tscn"),
	1: preload("res://scenes/levels/level_1.tscn"),
	2: preload("res://scenes/levels/level_2.tscn"),
	3: preload("res://scenes/levels/level_3.tscn"),
	4: preload("res://scenes/levels/level_4.tscn"),
}
const END_SCREEN = preload("res://scenes/ui/end_screen.tscn")

func load_next_level() -> void:
	current_level += 1
	if current_level +1 > LEVELS.size():
		save_high_score()
		get_tree().change_scene_to_packed.call_deferred(END_SCREEN)
	else:
		get_tree().change_scene_to_packed.call_deferred(LEVELS[current_level])

func restart_level() -> void:
	lives -= 1
	if lives <= 0:
		save_high_score()
		get_tree().change_scene_to_packed.call_deferred(END_SCREEN)
	else:
		get_tree().change_scene_to_packed(LEVELS[current_level])

func restart_game() -> void:
	current_level = 0
	lives = 3
	score = 0
	print(LEVELS[current_level])
	get_tree().change_scene_to_packed(LEVELS[current_level])
