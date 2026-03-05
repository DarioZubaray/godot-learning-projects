extends Node2D

@onready var brick_scene = preload("uid://dlyryq3xjc5n4")
@onready var marker_2d: Marker2D = $Marker2D

var columns := 32
var rows := 7
var margin_x : int
var margin_y : int
var _colors: Array[Color]

func _ready() -> void:
	margin_x = int($Marker2D.position.x)
	margin_y = int($Marker2D.position.y)
	_colors = _get_colors()
	_setup_level()

func _process(_delta: float) -> void:
	pass

func _setup_level() -> void:
	if rows < 9:
		rows = 2 + GameManager.level
	
	_colors.shuffle()
	
	for r in rows:
		for c in columns:
			var random_number = randi_range(0, 2)
			if random_number > 0:
				var new_brick = brick_scene.instantiate()
				add_child(new_brick)
				var position_x = margin_x + (34 * c)
				var position_y = margin_y + (34 * r)
				print("position -> x: %d, y: %d" % [position_x, position_y])
				new_brick.position = Vector2(position_x, position_y)
				
				var brick_sprite = new_brick.get_node("Sprite2D")
				if r <= 9:
					brick_sprite.modulate = _colors[0]
				if r < 6:
					brick_sprite.modulate = _colors[1]
				if r < 3:
					brick_sprite.modulate = _colors[2]

func _get_colors() -> Array[Color]:
	var colors: Array[Color] = [
		Color(0, 1, 1, 1),
		Color(0.54, 0.17, 0.89, 1),
		Color(0.68, 1, 0.18, 1),
		Color(1, 1, 1, 1)
	]
	return colors
