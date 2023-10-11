extends Node2D

signal rolled

var current_number := 0
var bar_length : int

func _ready():
	var num_label := Text.new(60, "0")
	num_label.set_text_position(Vector2(bar_length, 50))
	$Zero.add_child(num_label)

	bar_length = $Bar.texture.get_width()
	
	for i in range(9):
		var bar : Sprite2D = $Bar.duplicate()
		bar.position = $Zero.position + Vector2(i*bar_length, 0)
		bar.show()
		num_label = Text.new(60, str(i+1))
		num_label.set_text_position(Vector2(bar_length, 50))
		bar.add_child(num_label)
		add_child(bar)
	current_number = 9	


func add_ten() -> void:
	var num_label := Text.new(60, "0")
	num_label.set_text_position(Vector2(bar_length, 50))
	
	for i in range(10):
		var k = current_number + i
		var bar : Sprite2D = $Bar.duplicate()
		bar.position = $Zero.position + Vector2(k*bar_length, 0)
		bar.show()
		num_label = Text.new(60, str(k+1))
		num_label.set_text_position(Vector2(bar_length, 50))
		if i == 0:
			num_label.set_color(Color(0,0,1))
		else:
			num_label.set_color(Color(0,0,0))
		bar.add_child(num_label)
		await get_tree().create_timer(0.8).timeout
		add_child(bar)	
	
	
func roll_ten() -> void:
	for i in range(10):
		await get_tree().create_timer(0.2).timeout
		position.x -= bar_length
	emit_signal("rolled")

 
