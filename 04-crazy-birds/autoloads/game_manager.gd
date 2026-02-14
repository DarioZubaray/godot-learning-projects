extends Node

const MAIN = preload("uid://brpd008e2jp8p")

const LEVELS = {
	1: preload("uid://cddswqkia1krm"),
	2: preload("uid://fvngdwuxpnau"),
}
const SCORE_SCREEN = preload("uid://cmsuhp1yw8ghi")

var launches = 0
var current_level = 0
var enemies_left: int
var levels_launches = {}

func add_level_launches() -> void:
	levels_launches[current_level] = launches

func increase_launches() -> void:
	launches += 1

func set_enemies_left(enemies: int) -> void:
	enemies_left = enemies

func decrease_enemies_left() -> void:
	enemies_left -= 1
	
	if enemies_left == 0:
		add_level_launches()
		#load_next_level.call_deferred()
		SignalManager.emit_signal("level_completed")

func load_next_level() -> void:
	current_level += 1
	if current_level <= LEVELS.size():
		get_tree().change_scene_to_packed(LEVELS[current_level])
		launches = 0
	else:
		get_tree().change_scene_to_packed(SCORE_SCREEN)

func reset_game() -> void:
	get_tree().change_scene_to_packed(MAIN)
	launches = 0
	current_level = 0
	levels_launches = {}
