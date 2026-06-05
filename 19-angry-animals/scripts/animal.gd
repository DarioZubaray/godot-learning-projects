class_name Animal 
extends RigidBody2D

const DRAG_LIMIT_MAX = Vector2(0, 60)
const DRAG_LIMIT_MIN = Vector2(-60, 0)
const IMPULSE_DRAG : float = 25.0
const IMPULSE_MAX : float = 2000.0

@onready var label: Label = $Label
@onready var arrow_sprite: Sprite2D = $ArrowSprite
@onready var streach_sound: AudioStreamPlayer2D = $StreachSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound
@onready var kick_sound: AudioStreamPlayer2D = $KickSound

var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var is_dragging: bool = false
var _arrow_scale_x : float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drag") and is_dragging:
		#_start_release()
		call_deferred("_start_release")

func _ready() -> void:
	freeze = true
	_start = position
	_arrow_scale_x = arrow_sprite.scale.x

func _process(_delta: float) -> void:
	var debug_text = "Freeze: %s\nContact count: %s\nSleeping: %s" % [
		freeze,
		get_contact_count(),
		sleeping
	]
	debug_text += "\nis_dragging: %s\ndrag_start: %d, %d" % [
		is_dragging, _drag_start.x, _drag_start.y
	]
	debug_text += "\n_dragged_vector: %s" % [
		_dragged_vector
	]
	debug_text += "\nimpulse: %s" % [
		calculate_impulse().length()
	]
	
	label.text = debug_text

func _physics_process(_delta: float) -> void:
	if is_dragging: handle_dragging()

func calculate_impulse() -> Vector2:
	return _dragged_vector * IMPULSE_DRAG * -1.0

func handle_dragging() -> void:
	var new_drag_vector = get_global_mouse_position() - _drag_start
	new_drag_vector = new_drag_vector.clamp(DRAG_LIMIT_MIN, DRAG_LIMIT_MAX)
	
	var diff : Vector2 = new_drag_vector - _dragged_vector
	if diff.length() > 0 and !streach_sound.playing:
		streach_sound.play()
	
	scale_arrow()
	_dragged_vector = new_drag_vector
	position = _start + _dragged_vector

func _start_dragging() -> void:
	is_dragging = true
	_drag_start = get_global_mouse_position()
	arrow_sprite.show()

func _start_release() -> void:
	arrow_sprite.hide()
	is_dragging = false
	freeze = false
	launch_sound.play()
	var new_impulse: Vector2 = calculate_impulse()
	print("impulse: %s" % new_impulse)
	apply_central_impulse(new_impulse)
	SignalHub.emit_on_attemp_made()

func scale_arrow() -> void:
	var impulse_length : float = calculate_impulse().length()
	var percentage : float = clamp(impulse_length / IMPULSE_MAX, 0.0, 1.0)
	
	arrow_sprite.scale.x = lerpf(_arrow_scale_x, _arrow_scale_x * 2, percentage)
	arrow_sprite.rotation = (_start - position).angle()

func die() -> void:
	SignalHub.emit_animal_die()
	queue_free()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag"):
		input_event.disconnect(_on_input_event)
		_start_dragging()


func _on_body_entered(_body: Node) -> void:
	if not kick_sound.playing:
		kick_sound.play()

func _on_sleeping_state_changed() -> void:
		if sleeping:
			for body in get_colliding_bodies():
				if body is Cup:
					body.die()
			self.die()
