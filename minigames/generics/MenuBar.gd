extends Control

func _restart_game() -> void:
	get_tree().reload_current_scene()


func _go_to_menu() -> void:
	if get_tree().change_scene_to_file("res://world/counting_world.tscn") != OK:
		print("Could not change scene")

