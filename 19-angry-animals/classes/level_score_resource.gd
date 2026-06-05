class_name LevelScoreResource
extends Resource

const DEFAULT_SCORE : int = 999

@export var levels_scores : Dictionary[int, int]

func get_level_score(level: int) -> int:
	return levels_scores.get(level, DEFAULT_SCORE)

func try_update_best_score(level: int, score: int) -> void:
	if get_level_score(level) > score:
		levels_scores[level] = score
