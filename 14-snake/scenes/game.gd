extends Node

@export var snake_segment: PackedScene

@onready var hud: CanvasLayer = $Hud
@onready var move_timer: Timer = $MoveTimer
@onready var food: Sprite2D = $Food
@onready var game_over_menu: CanvasLayer = $GameOverMenu

# Game Variables
var score: int
var game_started: bool = false

# Grid variables
var cells := 20
var cell_size := 50

# Food variables
var food_position : Vector2
var regen_food := true

# Snake variables
var old_data: Array
var snake_data: Array[Vector2]
var snake: Array

# Movement variables
var start_position := Vector2(9, 9)
var up = Vector2(0, -1)
var down = Vector2(0, 1)
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var move_direction: Vector2
var can_move: bool

func _ready() -> void:
	new_game()

func new_game() -> void:
	get_tree().paused = false
	get_tree().call_group("segments", "queue_free")
	game_over_menu.hide()
	score = 0
	hud.get_node("ScorePanel/ScoreLabel").text = "Score: %d" % score
	move_direction = right
	can_move = true
	generate_snake()
	move_food()

func generate_snake() -> void:
	old_data.clear()
	snake_data.clear()
	snake.clear()
	# Starting with the start_position, create tail segments vertically down
	for i in range(3):
		add_segment(start_position + Vector2(0, i))

func add_segment(position: Vector2) -> void:
	snake_data.append(position)
	var snake_segment_scene = snake_segment.instantiate()
	snake_segment_scene.position = (position * cell_size + Vector2(0, cell_size))
	add_child(snake_segment_scene)
	snake.append(snake_segment_scene)

func _process(_delta: float) -> void:
	name_move()

func name_move() -> void:
	if can_move:
		# Update movement from keypresses
		update_movement_from_keypresses("move_down", down, up)
		update_movement_from_keypresses("move_up", up, down)
		update_movement_from_keypresses("move_right", right, left)
		update_movement_from_keypresses("move_left", left, right)

func update_movement_from_keypresses(action: String, current_direction: Vector2, opposite_direction: Vector2) -> void:
	if Input.is_action_just_pressed(action) and move_direction != opposite_direction:
		move_direction = current_direction
		can_move = true
		if not game_started:
			start_game()

func start_game() -> void:
	game_started = true
	move_timer.start()

func _on_move_timer_timeout() -> void:
	can_move = true
	# Use the snake's previous position to move the segments
	old_data = [] + snake_data
	snake_data[0] += move_direction
	for i in range(len(snake_data)):
		if i > 0:
			snake_data[i] = old_data[i - 1]
		
		snake[i].position = (snake_data[i] * cell_size) + Vector2(0, cell_size)
	
	check_out_of_bounds()
	check_self_eaten()
	check_food_eaten()

func check_out_of_bounds() -> void:
	var reach_top_limit = snake_data[0].x < 0
	var reach_down_limit = snake_data[0].x > cells - 1
	var reach_left_limit = snake_data[0].y < 0
	var reach_right_limit = snake_data[0].y > cells - 1
	if reach_top_limit or reach_down_limit or reach_left_limit or reach_right_limit:
		end_game()

func check_self_eaten() -> void:
	for i in range(1, len(snake_data)):
		if snake_data[0] == snake_data[i]:
			end_game()

func check_food_eaten() -> void:
	if snake_data[0] == food_position:
		score += 1
		hud.get_node("ScorePanel/ScoreLabel").text = "SCORE: %d" % score
		add_segment(old_data[-1])
		move_food()

func end_game() -> void:
	print("Game Over")
	game_over_menu.show()
	move_timer.stop()
	game_started = false
	get_tree().paused = true

func move_food() -> void:
	while regen_food:
		regen_food = false
		food_position = Vector2(randi_range(0, cells - 1), randi_range(0, cells - 1))
		for i in snake_data:
			if food_position == i:
				regen_food = true
	food.position = (food_position * cell_size) + Vector2(0, cell_size)
	regen_food = true

func _on_game_over_menu_on_restart_game() -> void:
	new_game()
