extends CharacterBody2D

@export var speed: float
@export var laser_scene: PackedScene

func create_laser() -> void:
	var laser_instance = laser_scene.instantiate()
	add_sibling(laser_instance)
	# get_parent().add_child(laser_instance)
	laser_instance.position = position

func process_inputs() -> void:
	var y_input = Input.get_axis("up", "down")
	velocity.y = y_input * speed
	
	var x_input = Input.get_axis("left", "right")
	velocity.x = x_input * speed
	# velocity = Vector2(x_input * speed, y_input * speed)
	# velocity = Vector2(x_input, y_input) * speed

# Movimiento de cuerpos fisicos (CharacterBody2D, RigidBody2D)
func _physics_process(_delta: float) -> void:
	if GameManager.is_game_over:
		queue_free()
		return
	
	var has_shoot = Input.is_action_just_pressed("shoot")
	if has_shoot:
		print("disparando...")
		create_laser()
	
	process_inputs()
	move_and_slide()

func _on_detection_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroids"):
		queue_free()
		GameManager.set_is_game_over(true)
