extends Node

var score: int = 0
var is_game_over: bool = false

func _process(_delta: float) -> void:
	if is_game_over and Input.is_action_just_pressed("shoot"):
		restart_game()

func restart_game() -> void:
	print("Reiniciar escena...")
	get_tree().reload_current_scene()
	is_game_over = false
	score = 0

func add_score(points: int) -> void:
	if not is_game_over:
		score += points
		print("score: " + str(score))

# Getter típico
func get_score() -> int:
	return score

# Setter típico
func set_is_game_over(value: bool) -> void:
	is_game_over = value
