extends Node2D
class_name Cashier

signal on_order_completed(cashier: Cashier)

@export var move_speed := 50.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cook_bar: CookBar = $CookBar

var current_customer: Customer
var counter_position: Vector2

var item_requested: Item
var item_counter_position: Vector2

func _ready() -> void:
	pass # Replace with function body.

func move_to_customer() -> void:
	# Create a Tween
	var tween = create_tween()
	tween.tween_property(self, "position", counter_position, 1.0)
	# Move
	animation_player.play("move")

func move_to_item_position() -> void:
	# Move
	animation_player.play("move")
	# Create a Tween
	var tween = create_tween()
	tween.tween_property(self, "position", item_counter_position, 1.0)
	tween.tween_interval(0.3)
	tween.finished.connect(func(): start_cook_time())
	# Start cooking time
	
func set_customer(customer: Customer) -> void:
	current_customer = customer
	customer.being_served = true
	counter_position = Vector2(customer.position.x, customer.position.y + 160)
	item_requested = customer.request_item
	item_counter_position = GameManager.get_item_position(item_requested)

func take_order() -> void:
	move_to_customer()
	await get_tree().create_timer(1.1).timeout
	current_customer.show_request()
	move_to_item_position()

func deliver_order() -> void:
	move_to_customer()
	await get_tree().create_timer(1.1).timeout
	current_customer.recieve_order()
	GameManager.current_coins += item_requested.profit
	GameManager.play_coins_vfx(global_position)
	
	if not current_customer.current_status_order <= 0:
		move_to_item_position()
	else:
		animation_player.play("idle")
		current_customer = null
		on_order_completed.emit(self)

func start_cook_time() -> void:
	animation_player.play("idle")
	cook_bar.show()
	cook_bar.cook_item(item_requested.cook_time)

func _on_cook_bar_on_cook_completed() -> void:
	cook_bar.hide()
	cook_bar.reset_bar()
	deliver_order()
