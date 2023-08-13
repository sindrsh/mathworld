extends Node2D


var bodies = 0
@onready var label: Label = get_node("Label")


func _on_area_2d_body_entered(body):
	bodies += 1
	label.text = str(bodies)


func _on_area_2d_body_exited(body):
	bodies -= 1
	label.text = str(bodies)
