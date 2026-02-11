extends Area2D

@export var min_speed: float
@export var max_speed: float
var random_speed : float
@export var min_rotation: float
@export var max_rotation: float
var random_rotation: float
@export var explosion_scene: PackedScene

@export var points: int

func _ready() -> void:
	random_speed = randf_range(min_speed, max_speed)
	print("random_speed: " + str(random_speed))
	random_rotation = randf_range(min_rotation, max_rotation)
	print("random_rotation: " + str(random_rotation))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= random_speed * delta
	rotation_degrees += random_rotation * delta

func _on_area_entered(area: Area2D) -> void:
	var is_player = area.is_in_group("player")
	var is_laser = area.is_in_group("laser")
	
	if is_laser:
		GameManager.add_score(points)
	
	if is_player or is_laser:
		queue_free()

func _on_body_entered(_body: Node2D) -> void:
	print("Cuerpo detectado")

func destroy() -> void:
	var explosion_instance = explosion_scene.instantiate()
	add_sibling(explosion_instance)
	explosion_instance.position = position
	queue_free()
