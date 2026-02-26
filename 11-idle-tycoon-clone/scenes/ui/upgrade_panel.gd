extends Control
class_name UpgradePanel

@onready var level: Label = %Level
@onready var item_name: Label = %ItemName
@onready var h_box_star: HBoxContainer = %HBoxStar
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var profit_label: Label = %ProfitLabel
@onready var cook_time_label: Label = %CookTimeLabel
@onready var upgrade_button: Button = %UpgradeButton

var item_ref: Item
var max_value: int
var current_value: int
var current_starts: int = -1

func _process(_delta: float) -> void:
	progress_bar.value = current_value / 25.0

func init_upgrade_panel(item: Item) -> void:
	item_ref = item
	item_ref.on_star_reached.connect(on_star_reached)
	item_name.text = item.id
	progress_bar.value = 0
	update_stats()

func update_stats() -> void:
	max_value = item_ref.max_level
	level.text = "Lv. %s" % item_ref.current_level
	profit_label.text = GameManager.format_coins(item_ref.profit)
	cook_time_label.text = str(item_ref.cook_time)
	upgrade_button.text = GameManager.format_coins(item_ref.upgrade_cost)

func on_star_reached() -> void:
	current_value = 0
	current_starts += 1
	var star: TextureRect = h_box_star.get_child(current_starts)
	star.modulate = Color(1, 1, 1)

func _on_upgrade_button_pressed() -> void:
	if GameManager.current_coins < item_ref.upgrade_cost:
		return
	SoundManager.play_ui()
	
	GameManager.current_coins -= item_ref.upgrade_cost
	current_value += 1
	item_ref.update_item()
	update_stats()
