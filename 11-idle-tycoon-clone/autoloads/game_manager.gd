extends Node

signal on_customer_request(customer: Customer)
signal on_customer_order_completed(customer: Customer)
signal on_new_cashier

const COIN_VFX = preload("uid://5xoo55fdjkg1")

@export var coffee: Item
@export var burger: Item

var coffee_counter_position := Vector2(425, 1250)
var burguer_counter_position := Vector2(680, 1250)
var current_coins: int = 200000

func get_random_item() -> Item:
	var items: Array = [coffee, burger]
	return items.pick_random()  

func get_item_position(item: Item) -> Vector2:
	match item.type:
		Item.Itemtype.Coffee:
			return coffee_counter_position
		Item.Itemtype.Burguer:
			return burguer_counter_position
		_:
			return Vector2.ZERO

func play_coins_vfx(spawn_position: Vector2) -> void:
	var coin_instance = COIN_VFX.instantiate()
	get_tree().root.add_child(coin_instance)
	SoundManager.play_coins()
	var new_position := Vector2(spawn_position.x, spawn_position.y - 70)
	coin_instance.global_position = new_position
	coin_instance.emitting = true
	coin_instance.finished.connect(func(): coin_instance.queue_free())

func format_coins(amount: int) -> String:
	var sufixes: Array = ["", "K", "M", "B", "T", "Q"]
	var index := 0
	var display_amount := float(amount)
	
	while display_amount >= 1000 and index < sufixes.size() - 1:
		display_amount /= 1000
		index += 1
	
	return str(round_to_one_decimal(display_amount)) + sufixes[index]

func round_to_one_decimal(display_amount: float) -> float:
	return floor(display_amount * 100) / 100
