extends Node
# plain text
#const SCORE_PATH : String = "user://tappy.tres"
# binary form
const SCORE_PATH : String = "user://tappy.res"

var high_score : int = 0:
	get:
		return high_score
	set(value):
		if value > high_score:
			high_score = value
			save_high_score()

func _ready() -> void:
	load_high_score()

func load_high_score() -> void:
	if ResourceLoader.exists(SCORE_PATH):
		var hs : HighScoreResource = load(SCORE_PATH)
		if hs: high_score = hs.high_core

func save_high_score() -> void:
	var hs : HighScoreResource = HighScoreResource.new()
	hs.high_core = high_score
	ResourceSaver.save(hs, SCORE_PATH)
