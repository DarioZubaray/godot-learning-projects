extends Node

var MAIN = load("uid://b0anip3hqx82i")
const GAME = preload("uid://uwvh47c3o5si")
const SIMPLE_TRANSITION = preload("uid://dw65gwg3y4jgg")

var next_scene : PackedScene

func change_to_next_scene() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)

func load_main_scene() -> void:
	next_scene = MAIN
	get_tree().change_scene_to_packed(SIMPLE_TRANSITION)

func load_game_scene() -> void:
	next_scene = GAME
	get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
