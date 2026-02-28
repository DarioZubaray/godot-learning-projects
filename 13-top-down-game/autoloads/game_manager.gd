extends Node

@warning_ignore("unused_signal")
signal on_enemy_died
@warning_ignore("unused_signal")
signal on_camara_shake

var player: Player
var coins: int = 500

const EXPLOSION_ANIMATION = preload("uid://bhpj6pf27hmbd")
const COIN = preload("uid://df5wxdh2s85bc")
const HIT_MATERIAL = preload("uid://d4ixwpmb561w6")
const DAMAGE_TEXT = preload("uid://bbodibp7vmq8c")

func play_explosion_animation(position: Vector2) -> void:
	var anim: AnimatedSprite2D = EXPLOSION_ANIMATION.instantiate()
	anim.global_position = position
	anim.z_index = 99
	get_parent().add_child(anim)
	await anim.animation_finished
	anim.queue_free()
	
func play_damage_text(position: Vector2, value: int) -> void:
	var damage_scene = DAMAGE_TEXT.instantiate() as DamageText
	get_parent().add_child(damage_scene)
	damage_scene.global_position = position
	damage_scene.set_text(value)

func create_coin(position: Vector2) -> void:
	var random_value = randf_range(0.0, 100.0)
	if random_value <= 70:
		print("Creando moneda")
		var coin_instance = COIN.instantiate()
		#coin_instance.global_position = position
		#add_child(coin_instance)
		get_tree().current_scene.add_child(coin_instance)
		coin_instance.global_position = position


func remove_coins(amount: int) -> void:
	print("remove coins: ", amount)
	coins -= amount
	if coins <= 0:
		coins = 0
