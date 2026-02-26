extends Node
class_name CashierManager

@export var cashier_scene: PackedScene
@export var spawn_position: Marker2D

@onready var counter_manager: CounterManager = %CounterManager

var cashier_list: Array[Cashier] = []

func _ready() -> void:
	GameManager.on_customer_request.connect(on_customer_request)
	GameManager.on_new_cashier.connect(add_cashier)
	add_cashier()

func add_cashier() -> void:
	var new_cashier = cashier_scene.instantiate()
	new_cashier.on_order_completed.connect(on_order_completed)
	add_child(new_cashier)
	new_cashier.position = spawn_position.position
	cashier_list.append(new_cashier)

func on_customer_request(customer: Customer) -> void:
	var free_cashier: Array[Cashier] = cashier_list.filter(func(x: Cashier): return x.current_customer == null)
	if not free_cashier:
		return
	var random_cashier: Cashier = free_cashier.pick_random()
	if random_cashier:
		random_cashier.set_customer(customer)
		random_cashier.take_order()

func on_order_completed(cashier: Cashier) -> void:
	var free_customer := counter_manager.get_first_available_customer()
	if free_customer:
		cashier.set_customer(free_customer)
		cashier.take_order()
