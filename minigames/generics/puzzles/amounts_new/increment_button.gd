extends Button

signal increment(_step: int, _place: int)
var step : int
var place : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	emit_signal("increment", step, place)
