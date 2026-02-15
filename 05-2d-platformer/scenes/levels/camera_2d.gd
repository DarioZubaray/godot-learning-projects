extends Camera2D

#@onready var player: CharacterBody2D = $"../Player"
var player 

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(_delta: float) -> void:
	if not player:
		return
	
	position = player.position
