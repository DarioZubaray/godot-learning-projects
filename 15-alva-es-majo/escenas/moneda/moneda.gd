extends Node2D

@onready var area_2d: Area2D = $Area2D
@onready var audio_stream_player: AudioStreamPlayer2D = $ReproductorSonidoMoneda

var contenedor_monedas: ContenedorMoneda

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_2d.body_entered.connect(_recogida)
	_iniciar_animacion()

func _recogida(_body) -> void:
	contenedor_monedas.moneda_recogidas()
	audio_stream_player.reparent(get_parent())
	audio_stream_player.play()
	#await audio_stream_player.finished
	queue_free()

func _iniciar_animacion() -> void:
	var tween: Tween = create_tween()
	tween.set_loops(0)
	tween.tween_property(self, "position:y", position.y - 5, 0.8).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position:y", position.y + 5, 0.8).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
