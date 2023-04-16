extends Node2D

var game : Control = preload("res://minigames/div/divisor1to10/Divisor1To9.tscn").instantiate() 
var hbox := HBoxContainer.new()
const DivisorButton = preload("res://minigames/div/divisor1to10/divisor_button.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	hbox.set("theme_override_constants/separation", 100)
	for i in range(1, 11):
		var button := DivisorButton.new()
		button.text = str(i)
		assert(button.connect("divisor_button_pressed", _on_button_pressed) == 0)
		hbox.add_child(button)
	add_child(hbox)
	
	
func _on_button_pressed(_name : String):
	hbox.hide()
	var number = str(hbox.get_node(_name).text)
	game.number = number
	add_child(game)
