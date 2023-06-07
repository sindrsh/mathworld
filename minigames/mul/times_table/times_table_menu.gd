extends MiniGame

var minigame_choice : TextureButton = preload("res://mini_game_choice.tscn").instantiate()
var dir_body : String = "res://minigames/mul/times_table/Times"
var numbers : PackedStringArray = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]

# Called when the node enters the scene tree for the first time.
func _add_generics():
	var margin = MarginContainer.new()
	add_child(margin)
	
	var container = GridContainer.new()
	margin.add_child(container)
	container.columns = 5
	
	for i in range(numbers.size()):
		var game_button = minigame_choice.duplicate()
		game_button.get_node('Label').text = str(i)
		game_button.scene_path = dir_body + numbers[i] + ".tscn"
		new_color(game_button, i)
		container.add_child(game_button)


func new_color(button, i):
	var new_mat = ShaderMaterial.new()
	new_mat.shader = button.material.shader
	new_mat.set("shader_parameter/Light", 0.1)
	new_mat.set("shader_parameter/Shift_Hue", i*0.08)
	button.material = new_mat
