extends CharacterBody2D

signal personaje_muerto

@export var material_personaje_rojo: ShaderMaterial
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox

var _velocidad: float = 100.0
var _velocidad_salto: float = 300.0
var _muerto: bool

func _ready() -> void:
	add_to_group("personajes")
	hurtbox.body_entered.connect(_on_area_2d_body_entered)

func _physics_process(delta: float) -> void:
	if _muerto:
		return
	
	# Gravedad
	velocity += get_gravity() * delta
	
	# Salto
	if Input.is_action_just_pressed("saltar") and is_on_floor():
		velocity.y = -_velocidad_salto
	
	# Movimiento lateral
	if Input.is_action_pressed("derecha"):
		velocity.x = _velocidad
		animated_sprite.flip_h = true
	elif Input.is_action_pressed("izquierda"):
		velocity.x = -_velocidad
		animated_sprite.flip_h = false
	else:
		velocity.x = 0
	
	move_and_slide()
	
	# Animacion
	if !is_on_floor():
		animated_sprite.play("saltar")
	elif velocity.x != 0:
		animated_sprite.play("correr")
	else:
		animated_sprite.play("idle")
	

func _on_area_2d_body_entered(_body: Node2D) -> void:
	print("personaje muerto")
	#animated_sprite.modulate = Color(18.892, 0.0, 0.0, 1.0)
	animated_sprite.material = material_personaje_rojo
	_muerto = true
	animated_sprite.stop()
	
	#var timer: Timer = Timer.new()
	#add_child(timer)
	#timer.start(0.5)
	#await timer.timeout
	await get_tree().create_timer(0.5).timeout
	personaje_muerto.emit()
	
	ControladorGlobal.sumar_muerte()
