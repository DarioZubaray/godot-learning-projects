extends Area2D
class_name Fox

signal point_obtained

@export var speed : float = 200.0
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sounds: AudioStreamPlayer2D = $sounds

func _physics_process(delta: float) -> void:
	#var move: float = 0.0
	#if Input.is_action_pressed("move_left"):
		#move -= speed
		#sprite_2d.flip_h = false
	#if Input.is_action_pressed("move_right"):
		#move += speed
		#sprite_2d.flip_h = true
	#position.x += move * delta
	
	var move: float = Input.get_axis("move_left", "move_right")
	if not is_zero_approx(move):
		sprite_2d.flip_h = move > 0.0
	position.x += move * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area is Dice:
		sounds.play()
		area.queue_free()
		point_obtained.emit()
