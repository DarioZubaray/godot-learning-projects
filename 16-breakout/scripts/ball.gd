extends CharacterBody2D

var speed := 200.0
var direction := Vector2.DOWN
var is_active := true

func _ready() -> void:
	speed = speed + (20 * GameManager.level)
	velocity = Vector2(speed * -1, speed)

func _physics_process(delta: float) -> void:
	if is_active:
		var collision = move_and_collide(velocity * delta)
		
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			
			if collision.get_collider().has_method("hit"):
				collision.get_collider().hit()
		
		if velocity.y > 0 and velocity.y < 100:
			velocity.y = -200
		
		if velocity.x == 0:
			velocity.x = -200

func _game_over() -> void:
	GameManager.score =  0
	GameManager.level =  1
	get_tree().reload_current_scene.call_deferred()

func _on_death_zone_body_entered(_body: Node2D) -> void:
	_game_over()
