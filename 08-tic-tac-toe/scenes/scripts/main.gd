extends Node

@export var circle_scene: PackedScene
@export var cross_scene: PackedScene
@onready var board: Sprite2D = $Board
@onready var player_panel: Panel = $PlayerPanel
@onready var game_over_menu: CanvasLayer = $GameOverMenu

enum Player { NONE = 0,  X = 1, O = -1 }
var grid_data: Array
var moves : int
var current_player: int
var winner :int
var temp_marker: Node
var player_panel_pos: Vector2i

var grid_pos: Vector2i
var middle_grid : Vector2i
var board_size: int
var cell_size: int

var col_sum : int
var row_sum : int
var diagonal1_sum : int
var diagonal2_sum : int

func _ready() -> void:
	randomize()
	setup()
	new_game()

func get_random_player() -> int:
	return Player.X if randi() % 2 == 0 else Player.O

func setup() -> void:
	#get the size of the board
	board_size = board.texture.get_width()
	print("Board size: " + str(board_size))
	#divide board size by 3 to get the size of individual cell
	@warning_ignore("integer_division")
	cell_size = board_size / 3
	print("cell size: " + str(cell_size))
	#get coordinates of small panel on right size of individual window
	player_panel_pos = player_panel.get_position()

func new_game() -> void:
	current_player = get_random_player()
	print("Player %s starts" % current_player)
	moves = 0
	winner = Player.NONE
	grid_data = [
		[Player.NONE, Player.NONE, Player.NONE],
		[Player.NONE, Player.NONE, Player.NONE],
		[Player.NONE, Player.NONE, Player.NONE]
	]
	col_sum = 0
	row_sum = 0
	diagonal1_sum = 0
	diagonal2_sum = 0
	#clear all markers
	get_tree().call_group("circles", "queue_free")
	get_tree().call_group("crosses", "queue_free")
	#create a marker to show starting player's turn
	@warning_ignore("integer_division")
	create_marker(player_panel_pos + Vector2i(cell_size /2, cell_size / 2), true)
	game_over_menu.hide()
	get_tree().paused = false

func _input(event) -> void:
	if is_valid_click(event):
		print("Grid position clicked: %s" % grid_pos)
		handle_move()

func is_valid_click(event) -> bool:
	if event is InputEventMouseButton: #Check if the event is a mouse event
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed: #check if the event is a mouse button left and it has been pressed
			if event.position.x < board_size: #check if the mouse is on the game board
				grid_pos = get_grid_pos(event.position) #convert mouse position into grid location
				if grid_data[grid_pos.x][grid_pos.y] == Player.NONE: #check if the cell is ocupied
					return true
	return false

func get_grid_pos(position: Vector2) -> Vector2i:
	return Vector2i(position / cell_size)

func handle_move() -> void:
	place_marker()
	check_game_state()
	switch_player()
	update_panel_marker()

func place_marker() -> void:
	moves += 1
	grid_data[grid_pos.x][grid_pos.y] = current_player
	#place that player's marker
	@warning_ignore("integer_division")
	middle_grid = Vector2i(cell_size/2, cell_size/2)
	create_marker(grid_pos * cell_size + middle_grid)

func check_game_state() -> void:
	if check_win() != Player.NONE:
		print("Game over")
		get_tree().paused = true
		game_over_menu.show()
		if winner == Player.X:
			game_over_menu.get_node("ResultLabel").text = "Player X Wins!"
		else:
			game_over_menu.get_node("ResultLabel").text = "Player O Wins!"
	#check if the board have been filled
	elif moves == 9:
		print("Game over")
		get_tree().paused = true
		game_over_menu.get_node("ResultLabel").text = "It's a tie!"
		game_over_menu.show()

func switch_player() -> void:
	current_player *= -1

func update_panel_marker() -> void:
	temp_marker.queue_free()
	create_marker(player_panel_pos + middle_grid, true)
	print(grid_data)

func create_marker(position: Vector2i, temp = false) -> void:
	#create a marker node and add it as a child
	if current_player == Player.X:
		var cross = cross_scene.instantiate()
		cross.position = position
		add_child(cross)
		if temp:
			temp_marker = cross
	if current_player == Player.O:
		var circle = circle_scene.instantiate()
		circle.position = position
		add_child(circle)
		if temp:
			temp_marker = circle

func check_win() -> int:
	#add up the markers in each row, column and diagonal
	for i in len(grid_data):
		row_sum = grid_data[i][0] + grid_data[i][1] + grid_data[i][2]
		col_sum = grid_data[0][i]+ grid_data[1][i] + grid_data[2][i]
		diagonal1_sum = grid_data[0][0]+ grid_data[1][1] + grid_data[2][2]
		diagonal2_sum = grid_data[0][2]+ grid_data[1][1] + grid_data[2][0]
		#check if either plaer has all of the marker in one line
		if row_sum == 3 or col_sum == 3 or diagonal1_sum == 3 or diagonal2_sum == 3:
			winner = Player.X
		if row_sum == -3 or col_sum == -3 or diagonal1_sum == -3 or diagonal2_sum == -3:
			winner = Player.O
	return winner


func _on_game_over_menu_restart() -> void:
	new_game()
