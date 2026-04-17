extends Node2D


const DICE = preload("uid://c6wsbyjga68up")
const GAME_OVER = preload("uid://c0orcx0ncovyq")
const MARGIN := 80.0
const STOPPABLE : String = "stoppable"

@onready var fox: Fox = $Pausable/Fox
@onready var timer: Timer = $Pausable/Timer
@onready var pausable: Node = $Pausable
@onready var label: Label = $Label
@onready var game_over_label: Label = $GameOverLabel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var score: int = 0

func _ready() -> void:
	get_tree().paused = false
	timer.timeout.connect(_on_timeout)
	fox.point_obtained.connect(_on_point_obtained)
	game_over_label.visible = false
	spawn_dice()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func spawn_dice() -> void:
	var new_dice: Dice = DICE.instantiate()
	var vpr: Rect2 = get_viewport_rect()
	var new_x = randf_range(
		vpr.position.x + MARGIN, vpr.end.x - MARGIN
	)
	new_dice.position = Vector2(new_x, -MARGIN)
	pausable.add_child(new_dice)
	new_dice.game_over.connect(_on_game_over)

func _on_game_over() -> void:
	print("Game over")
	#stop_all()
	audio_stream_player.stop()
	audio_stream_player.stream = GAME_OVER
	audio_stream_player.play()
	game_over_label.visible = true
	get_tree().paused = true

func stop_all() -> void:
	var stoppable : Array[Node] = get_tree().get_nodes_in_group(STOPPABLE)
	for item in stoppable:
		item.set_physics_process(false)
	timer.stop()

func _on_timeout() -> void:
	spawn_dice()

func _on_point_obtained() -> void:
	print("new point obtaineda")
	score += 1
	label.text = "%04d" % score
