extends Node2D
# Test script for the clickable
# TODO: implement GUT framework to automate this




func _on_clickable_on_click():
	print("clickable was clicked")


func _on_clickable_on_hover_start():
	print("hover started...")


func _on_clickable_on_hover_stop():
	print("hover stopped...")
