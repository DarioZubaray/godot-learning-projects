extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

func hit() -> void:
	GameManager.add_points(1)
	
	cpu_particles_2d.emitting = true
	sprite_2d.visible = false
	collision_shape_2d.disabled = true
	
	var bricks_left = get_tree().get_nodes_in_group("Bricks")
	if bricks_left.size() == 1:
		get_parent().get_node("Ball").is_active = false
		await get_tree().create_timer(1).timeout
		GameManager.level += 1
		get_tree().reload_current_scene()
	else:
		await get_tree().create_timer(1).timeout
		queue_free()
