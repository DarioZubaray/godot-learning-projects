extends Node2D
class_name Customer

@onready var body: Sprite2D = %Body
@onready var face: Sprite2D = %Face
@onready var hand_left: Sprite2D = %HandLeft
@onready var hand_right: Sprite2D = %HandRight
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var item_box: Control = $ItemBox
@onready var item_image: TextureRect = %ItemImage
@onready var item_label: Label = %ItemLabel

var request_item: Item
var request_quantity: int
var current_status_order: int

var counter_position: Vector2
var being_served: bool
var waiting_order: bool

func _process(_delta: float) -> void:
	item_label.text = str(current_status_order)

func init_customer(item: Item, quantity: int) -> void:
	request_item = item
	request_quantity = quantity
	current_status_order = quantity

func show_request() -> void:
	item_box.show()
	item_image.texture = request_item.sprite
	item_label.text = str(request_quantity)

func set_sprites(data: CustomerData) -> void:
	body.texture = data.body
	face.texture = data.face
	hand_left.texture = data.hand
	hand_right.texture = data.hand

func play_move_animation() -> void:
	animation_player.play("move")

func move_to_counter() -> void:
	animation_player.play("move")
	var counter_top_position = Vector2(counter_position.x, position.y)
	var tween = create_tween()
	tween.tween_property(self, "position", counter_top_position, 1.0)
	tween.tween_interval(0.2)
	tween.tween_property(self, "position", counter_position, 1.0)
	tween.tween_interval(0.5)
	tween.finished.connect(
		func():
			animation_player.play("idle")
			waiting_order = true
			GameManager.on_customer_request.emit(self)
	)
	
func recieve_order() -> void:
	current_status_order -= 1
	if current_status_order <= 0:
		order_completed()

func order_completed() -> void:
	item_box.hide()
	waiting_order = false
	var counter_top_position = counter_position.y - 180
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(counter_position.x, counter_top_position), 1.0)
	tween.tween_interval(0.2)
	tween.tween_property(self, "position", Vector2(counter_position.x + 800, counter_top_position), 3.0)
	tween.tween_interval(0.2)
	tween.finished.connect(func(): GameManager.on_customer_order_completed.emit(self))
