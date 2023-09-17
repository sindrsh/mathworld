extends Area2D

signal hit(_name : String)

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(area_entered.connect(_on_tick_entered) == 0)


func _on_tick_entered(_area: Area2D) -> void:
	emit_signal("hit", name)
