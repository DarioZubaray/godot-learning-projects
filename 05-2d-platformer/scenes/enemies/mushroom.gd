extends Enemy

@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _ready() -> void:
	super()

func _physics_process(delta: float) -> void:
	if is_on_wall() or not ray_cast_2d.is_colliding():
		flip()
	
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.x = -speed
	
	move_and_slide()

func flip() -> void:
	scale.x *= -1
	speed = -speed
