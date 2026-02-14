extends RigidBody2D

const MAX_DRAG_DISTANCE = 150

@export var force_multiplier: float
@onready var line_2d: Line2D = $Line2D

var is_dragged = false
var start_position

func _ready() -> void:
	start_position = position
	sleeping_state_changed.connect(_on_sleeping_state_changed)

func _physics_process(_delta: float) -> void:
	if is_dragged:
		drag()
		upodate_line()
		check_release()

func upodate_line() -> void:
	line_2d.clear_points()
	line_2d.add_point(to_local(start_position))
	line_2d.add_point(to_local(position))

func drag() -> void:
	var mouse_position = get_global_mouse_position()
	var drag_vector = mouse_position -  start_position
	if drag_vector.length() > MAX_DRAG_DISTANCE:
		drag_vector = drag_vector.normalized() * MAX_DRAG_DISTANCE
	
	if drag_vector.x > 0:
		drag_vector.x = 0
	
	position = start_position + drag_vector

func check_release() -> void:
	if Input.is_action_just_released("drag"):
		launch()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		is_dragged = true

func launch() -> void:
	line_2d.clear_points()
	is_dragged = false
	freeze = false
	var force_vector = start_position - position
	apply_impulse(force_vector * force_multiplier)
	GameManager.increase_launches()
	SignalManager.emit_signal("player_launched")

func _on_sleeping_state_changed() -> void:
	if sleeping:
		queue_free()
