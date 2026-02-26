extends Node
class_name CounterManager

@export var counter_positions: Array[Marker2D]

var counter: Dictionary[int, Customer] = {
	0: null,
	1: null,
	2: null,
	3: null
}

func _ready() -> void:
	GameManager.on_customer_order_completed.connect(on_customer_order_completed)

func get_free_index() -> int:
	for key in counter:
		if counter[key] == null:
			return key
	return -1

func assign_customer(customer: Customer) -> void:
	var index = get_free_index()
	if index == -1:
		return
	counter[index] = customer
	var free_counter_position: Vector2 = counter_positions[index].position
	customer.counter_position = free_counter_position

func get_first_available_customer() -> Customer:
	for customer: Customer in counter.values():
		if customer != null:
			if customer.waiting_order and not customer.being_served:
				return customer
	return null

func on_customer_order_completed(customer: Customer) -> void:
	for x: int in counter:
		if counter[x] == customer:
			counter[x] = null
	
