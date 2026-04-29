extends Node2D

const SPEED : float = -120.0
@onready var laser: Area2D = $Laser
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	SignalHub.on_plane_died.connect(_on_plane_died)

func _process(delta: float) -> void:
	position.x += SPEED * delta

func _on_screen_notifier_screen_exited() -> void:
	print("Pipe exited")
	queue_free()

func _on_laser_body_exited(body: Node2D) -> void:
	if body is Tappy:
		print("Point?")
		disconnect_laser()
		audio_stream_player.play()
		SignalHub.emit_on_point_scored()

func _on_life_timer_timeout() -> void:
	print("if notifier screen exited did not fired, timeout to queue free")
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Tappy:
		print("_on_body_entered", body.name)
		body.die()
 
func _on_plane_died() -> void:
	disconnect_laser()

func disconnect_laser() -> void:
	if laser.body_exited.is_connected(_on_laser_body_exited):
		laser.body_exited.disconnect(_on_laser_body_exited)
