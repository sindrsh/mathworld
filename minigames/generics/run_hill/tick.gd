extends Area2D
class_name Tick

signal hit(_name : String)
var value : int
var tick_is_obstacle := false:
	set(_bool):
		tick_is_obstacle = _bool
		if tick_is_obstacle:
			$ObstacleShape.set_deferred("disabled", false)
		
var next_obstacle : Area2D
var has_been_hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(area_entered.connect(_on_tick_entered) == 0)
	assert($Button.pressed.connect(_on_tick_pressed) == 0)


# Does this method ever get called or connected to?
# -- FireSquid
func _on_tick_entered(_area: Area2D) -> void:
	emit_signal("hit", name)


func _on_tick_pressed() -> void:
	pass
