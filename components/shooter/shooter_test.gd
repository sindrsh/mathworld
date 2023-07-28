extends Node2D


@onready var shooter: Shooter = get_node("shooter")

func _input(event):
  # when left mouse button is pressed run spawn on shooter
  if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
    shooter.spawn(200, 800)