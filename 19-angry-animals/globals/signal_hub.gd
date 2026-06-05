extends Node

signal animal_die
signal on_cup_destroy
signal on_attemp_made 

func emit_animal_die() -> void:
	animal_die.emit()

func emit_on_cup_destroy() -> void:
	on_cup_destroy.emit()

func emit_on_attemp_made() -> void:
	on_attemp_made.emit()
