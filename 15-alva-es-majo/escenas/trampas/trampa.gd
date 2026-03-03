extends RigidBody2D

@onready var ray_cast: RayCast2D = $RayCast2D

func _physics_process(_delta: float) -> void:
	if ray_cast.get_collider() != null:
		freeze = false
	
