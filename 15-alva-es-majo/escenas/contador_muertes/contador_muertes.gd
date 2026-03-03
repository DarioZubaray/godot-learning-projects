extends Control

@onready var valor: Label = $ColorRect/HBoxContainer/Valor

func _ready() -> void:
	ControladorGlobal.muertes_actualizado.connect(_actualizar_texto)
	_actualizar_texto()

func _actualizar_texto() -> void:
	valor.text = str(ControladorGlobal.muertes)
