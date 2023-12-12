extends MiniGame

#explanation

var bar_length : int
var insight_button : TextureButton = preload("res://minigames/generics/insight_games/insight_achieved_button.tscn").instantiate()

func _add_specifics():
	world_part = "counting"
	id = "num_line_0_to_9"
	minigame_type = NUMBER_LINE
	$Zero.position = Vector2(500, 500)
	var num_label := Text.new(60, "0")
	num_label.set_text_position(Vector2(bar_length, 50))
	$Zero.add_child(num_label)

	bar_length = $Bar.texture.get_width()
	
	for i in range(9):
		await get_tree().create_timer(0.8).timeout
		var bar : Sprite2D = $Bar.duplicate()
		bar.position = $Zero.position + Vector2(i*bar_length, 0)
		bar.show()
		num_label = Text.new(60, str(i+1))
		num_label.set_text_position(Vector2(bar_length, 50))
		bar.add_child(num_label)
		add_child(bar)
	
	add_child(insight_button)
