extends Resource
class_name Item

signal on_star_reached

enum Itemtype {
	Coffee,
	Burguer
}

@export var id: String
@export var type: Itemtype
@export var sprite: Texture2D

@export_group("cook")
@export var cook_time := 10.0
@export var cook_time_reduce_percentage := 0.5

@export_group("upgrade")
@export var upgrade_cost := 3.0
@export var upgrade_multiplier := 1.3

@export_group("profit")
@export var profit := 4.0
@export var profit_multiplier := 1.2

var max_level := 75
var current_level := 0

func update_item() -> void:
	if current_level >= max_level:
		return
	
	current_level += 1
	upgrade_cost = ceil(upgrade_cost * upgrade_multiplier)
	profit = ceil(profit * profit_multiplier)
	
	if current_level % 25 == 0:
		cook_time = ceil(cook_time * cook_time_reduce_percentage)
		upgrade_cost *= 3
		profit *= 3
		on_star_reached.emit()
		
