extends Node2D

const CENTER = Vector2(640, 360)
var player_Score = 0
var computer_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_goal_left_body_entered(body: Node2D) -> void:
	print("La pelota entro en el area izquierda")
	computer_score += 1
	$ComputerScore.text = str(computer_score)
	reset()

func _on_goal_right_body_entered(body: Node2D) -> void:
	print("La pelota entro en el area derecha")
	player_Score += 1
	$PlayerScore.text = str(player_Score)
	reset()

func reset():
	$Ball.position = CENTER
	$Ball.call("set_ball_velocity")
	$Player.position.y = CENTER.y
	$Computer.position.y = CENTER.y
