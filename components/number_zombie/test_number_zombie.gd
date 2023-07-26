extends Node2D


@onready var number_zombie = get_node("NumberZombie")


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			number_zombie.shoot(3)
