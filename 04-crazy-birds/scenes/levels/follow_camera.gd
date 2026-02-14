extends Camera2D

var player : Node
var start_position = Vector2(960.0, 540.0)

func _process(_delta: float) -> void:
	# if player == null:
	if not player:
		return
	
	if player.position.x > position.x:
		position.x = player.position.x

func _on_player_spawner_player_spawned(player_instance: Node) -> void:
	player = player_instance
	position = start_position
