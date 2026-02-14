extends RigidBody2D

@export var velocity_threshold: float
@export var explosion_scene: PackedScene

func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		destroy_enemy()
		return
	
	if body is RigidBody2D and body.linear_velocity.length() > velocity_threshold:
		destroy_enemy()

func destroy_enemy() -> void:
	create_explosion()
	GameManager.decrease_enemies_left() 
	queue_free()
	

func create_explosion() -> void:
	var explosion_instance = explosion_scene.instantiate()
	add_sibling(explosion_instance)
	explosion_instance.position = position
	
