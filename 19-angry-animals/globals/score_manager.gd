extends Node

const LEVEL_SCORES : LevelScoreResource = preload("uid://2sk4kbh2alff")
const SCORES_PATH = "res://animals_scores.res"

var level_selected : int = 1:
	get: return level_selected
	set(value): level_selected = value

var _level_scores : LevelScoreResource = LevelScoreResource.new()

func _ready() -> void:
	load_score_from_file()

func get_level_best(level: int) -> int:
	return _level_scores.get_level_score(level)

func set_score_for_scurrent_level(score: int) -> void:
	_level_scores.try_update_best_score(level_selected, score)
	save_score_from_file()
	
func load_score_from_file() -> void:
	if ResourceLoader.exists(SCORES_PATH):
		_level_scores = load(SCORES_PATH)

func save_score_from_file() -> void:
	ResourceSaver.save(_level_scores, SCORES_PATH)
