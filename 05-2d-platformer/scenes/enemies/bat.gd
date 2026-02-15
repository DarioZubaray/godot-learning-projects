extends Enemy

func _ready() -> void:
	super()

func _physics_process(_delta: float) -> void:
	if not player:
		return
	
	flip()
	follow_player()
	
	move_and_slide()

func flip() -> void:
	animated_sprite_2d.flip_h = player.position.x > position.x

func follow_player() -> void:
	var direction = player.position - position
	var direction_normalized = direction.normalized()
	velocity = speed * direction_normalized
