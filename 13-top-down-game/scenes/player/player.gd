extends CharacterBody2D
class_name Player

@export var move_speed := 700.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: Weapon = $Weapon
@onready var health_component: HealthComponent = $HealthComponent
@onready var health_bar: HealthBar = $HealthBar

var can_move := true
var mouse_position: Vector2

func _process(_delta: float) -> void:
	if not can_move:
		return
	
	get_mouse_position()
	update_animations()
	update_player_rotation()
	update_weapon_rotation()

func _physics_process(_delta: float) -> void:
	if not can_move:
		return
	
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var movement := direction * move_speed
	velocity = movement
	
	move_and_slide()

func setup_weapon(weapon_data: WeaponData) -> void:
	weapon.setup(weapon_data)
	weapon.show()

func update_player_rotation() -> void:
	if mouse_position.x > global_position.x:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true

func update_weapon_rotation() -> void:
	if mouse_position.x > global_position.x:
		weapon.rotate_weapon(false)
	else:
		weapon.rotate_weapon(true)
	
	weapon.look_at(mouse_position)

func update_animations() -> void:
	if velocity.length() > 0:
		animated_sprite.play("move")
	else:
		animated_sprite.play("idle")

func get_mouse_position() -> void:
	mouse_position = get_global_mouse_position()

func _on_health_component_on_damaged() -> void:
	var health_value = health_component.current_health / health_component.max_health
	health_bar.set_value(health_value)
	animated_sprite.material = GameManager.HIT_MATERIAL
	await get_tree().create_timer(0.3).timeout
	animated_sprite.material = null

func _on_health_component_on_defeated() -> void:
	animated_sprite.play("dead")
	can_move = false
