extends Area2D
class_name NumberFruit

var number = -1  # -1 means that no number has been set. I assume that negative numbers won't be covered in this game
@onready var label: Label = get_node("Label")

signal eaten(n: int)

func set_number(num) -> void:
	number = num
	label.text = str(number)
	
func eat():
	emit_signal("eaten", number)
	queue_free()
