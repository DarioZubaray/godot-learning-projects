extends Node
class_name ContenedorMoneda

var _total_monedas: int
var _monedas_recogidas: int

func _ready() -> void:
	var monedas := get_children()
	_total_monedas = monedas.size()
	
	for moneda in monedas:
		moneda.contenedor_monedas = self
	
func moneda_recogidas() -> void:
	_monedas_recogidas += 1
	
	if _monedas_recogidas == _total_monedas:
		print("Nivel superado")
		var nivel = get_parent()
		var escena_principal = nivel.get_parent()
		escena_principal.siguiente_nivel()
