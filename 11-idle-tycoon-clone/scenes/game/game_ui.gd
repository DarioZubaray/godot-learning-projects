extends CanvasLayer
class_name GameUI

@export var cashier_1_cost := 50
@export var cashier_2_cost := 500
@export var cashier_3_cost := 5000
@export var faster_coffee_cost := 250
@export var faster_burger_cost := 1000

@onready var coffee_upgrade_panel: UpgradePanel = $CoffeeUpgradePanel
@onready var burger_upgrade_panel: UpgradePanel = $BurgerUpgradePanel
@onready var current_coins: Label = %CurrentCoins
@onready var shop: Panel = $Shop
@onready var options: Panel = $Options

@onready var new_cashier_card_1: Panel = %NewCashierCard_1
@onready var new_cashier_button_1: Button = %NewCashierButton_1
@onready var faster_coffee_card: Panel = %FasterCoffeeCard
@onready var faster_coffee_button: Button = %FasterCoffeeButton
@onready var new_cashier_card_2: Panel = %NewCashierCard_2
@onready var new_cashier_button_2: Button = %NewCashierButton_2
@onready var faster_burger_card: Panel = %FasterBurgerCard
@onready var faster_burger_button: Button = %FasterrBurgerButton
@onready var new_cashier_card_3: Panel = %NewCashierCard_3
@onready var new_cashier_button_3: Button = %NewCashierButton_3

func _ready() -> void:
	coffee_upgrade_panel.init_upgrade_panel(GameManager.coffee)
	burger_upgrade_panel.init_upgrade_panel(GameManager.burger)
	
	new_cashier_button_1.text = GameManager.format_coins(cashier_1_cost)
	new_cashier_button_2.text = GameManager.format_coins(cashier_2_cost)
	new_cashier_button_3.text = GameManager.format_coins(cashier_3_cost)
	faster_burger_button.text = GameManager.format_coins(faster_burger_cost)
	faster_coffee_button.text = GameManager.format_coins(faster_coffee_cost)

func _process(_delta: float) -> void:
	current_coins.text = GameManager.format_coins(GameManager.current_coins)

func open_close_shop_panel() -> void:
	shop.visible = true if not shop.visible else false
	options.visible = false

func _on_coffee_texture_button_pressed() -> void:
	SoundManager.play_ui()
	burger_upgrade_panel.hide()
	coffee_upgrade_panel.visible = !coffee_upgrade_panel.visible

func _on_burger_texture_button_pressed() -> void:
	SoundManager.play_ui()
	coffee_upgrade_panel.hide()
	burger_upgrade_panel.visible = !burger_upgrade_panel.visible


func _on_new_cashier_button_1_pressed() -> void:
	if GameManager.current_coins < cashier_1_cost:
		return

	SoundManager.play_ui()
	GameManager.current_coins -= cashier_1_cost
	GameManager.on_new_cashier.emit()
	new_cashier_card_1.hide()

func _on_new_cashier_button_2_pressed() -> void:
	if GameManager.current_coins < cashier_2_cost:
		return

	SoundManager.play_ui()
	GameManager.current_coins -= cashier_2_cost
	GameManager.on_new_cashier.emit()
	new_cashier_card_2.hide()

func _on_new_cashier_button_3_pressed() -> void:
	if GameManager.current_coins < cashier_3_cost:
		return

	SoundManager.play_ui()
	GameManager.current_coins -= cashier_3_cost
	GameManager.on_new_cashier.emit()
	new_cashier_card_3.hide()

func _on_faster_coffee_button_pressed() -> void:
	if GameManager.current_coins < faster_coffee_cost:
		return

	SoundManager.play_ui()
	GameManager.current_coins -= faster_coffee_cost
	GameManager.coffee.cook_time = 1
	faster_coffee_card.hide()

func _on_fasterr_burger_button_pressed() -> void:
	if GameManager.current_coins < faster_burger_cost:
		return

	SoundManager.play_ui()
	GameManager.current_coins -= faster_burger_cost
	GameManager.burger.cook_time = 2
	faster_burger_card.hide()

func _on_shop_button_pressed() -> void:
	open_close_shop_panel()

func _on_music_h_slider_value_changed(value: float) -> void:
	var musix_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(musix_index, linear_to_db(value))

func _on_sfxh_slider_value_changed(value: float) -> void:
	var sfx_index = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))

func _on_options_button_pressed() -> void:
	options.visible = true if not options.visible else false
	shop.visible = false
