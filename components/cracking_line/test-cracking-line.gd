extends Node2D


@onready var line: CrackingLine = get_node("CrackingLine")


func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		line.crack()
