extends Area2D

var number_text := Text.new(40, "0")
var value : int


func _physics_process(_delta):
	var new_value := 0
	for area in get_overlapping_areas():
		var limit_box : Vector2 = $Border.shape.size - area.texture_size
		var distance : Vector2 = global_position - area.global_position
		limit_box = limit_box/2
		if abs(distance.y) < limit_box.y:
			if abs(distance.x) < limit_box.x:
				new_value += area.value
	value = new_value
	number_text.text = str(value)


func _arrange(border_size : Vector2) -> void:
	$Border.shape.size = border_size
	$ColorRect.size = border_size
	$ColorRect.position = -border_size/2
	$CenterContainer.position.x += border_size.x/2 - 11.0
	$CenterContainer.position.y = -border_size.y/2
	$CenterContainer.add_child(number_text)	

