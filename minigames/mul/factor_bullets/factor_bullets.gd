extends "res://minigames/generics/falling_bubbles/falling_bubbles.gd"

var primes : PackedInt32Array = [2, 3, 5, 7]
var products : Array
var factors : Array
var bubble_string : Text
var chosen_factors : Array
var connection_texture : Texture2D = preload("res://minigames/mul/factor_bullets/assets/mult_connection.svg")
var bubble_positions : Array = [2, -1, 1]


func _add_specifics() -> void:
	for i in primes:
		for j in primes:
			if i*j < 200:
				var factorization = [i, j]
				factorization.sort()
				if factorization not in products:
					products.append(factorization)
	
	for i in primes:
		for j in primes:
			for k in primes:
				if i*j*k < 200:
					var factorization = [i, j, k]
					factorization.sort()
					if factorization not in products:
						products.append(factorization)

	for i in primes:
		for j in primes:
			for k in primes:
				for l in primes:
					if i*j*k*l < 200:
						var factorization = [i, j, k, l]
						factorization.sort()
						if factorization not in products:
							products.append(factorization)
	randomize()
	products.shuffle()		
	_make_task()
						
func _make_task() -> void:
	if bubble:
		bubble.queue_free()
	for bullet in bullet_container.get_children():
		bullet.queue_free()
	_add_bubble(products.pop_back())
	
	_new_bullet_selection()
	
func _new_bullet_selection() -> void:
	var x_aligns := [-3, -1, 1, 3]
	for i in range(4):
		_add_bullet(primes[i], x_aligns[i])


func _on_target_reached(_name : String) -> void:
	var finished_bullet = bullet_container.get_node(_name)
	if finished_bullet.equals_bubble:
		if _accomplished():
			await get_tree().create_timer(0.1).timeout
			_end_game()
		else:
			var chosen_factor : int = finished_bullet.int_value[0]
			finished_bullet.queue_free()
			chosen_bubble = ''
			chosen_factors.append(chosen_factor)
			bubble.int_value.erase(chosen_factor)
			if bubble.int_value:
				var product : int = 1
				for n in bubble.int_value:
					product *= n
				bubble_string.set_new_text(str(product))
				bubble_string.center_text()
				var connnection := Sprite2D.new()
				connnection.texture = connection_texture
				
				var factor_sprite := Sprite2D.new()
				factor_sprite.texture = bubble.button.texture_normal
				factor_sprite.position.x = bubble_positions.pop_back()*(connection_texture.get_width() + bubble.button.texture_normal.get_width())
				if factor_sprite.position.x > 0:
					connnection.position.x = factor_sprite.position.x - (connection_texture.get_width() + bubble.button.texture_normal.get_width())/2.0
				else:
					connnection.position.x = factor_sprite.position.x + (connection_texture.get_width() + bubble.button.texture_normal.get_width())/2.0
				bubble.add_child(connnection)
				var factor_text := Text.new(40, str(chosen_factor))
				factor_text.center_text()
				factor_sprite.add_child(factor_text)
				bubble.add_child(factor_sprite)
				_new_bullet_selection()
			if bubble.int_value.size() == 1:
				get_tree().paused = true
				await get_tree().create_timer(1.5).timeout
				get_tree().paused = false
				score += 1
				_make_task()
	else:
		get_tree().reload_current_scene()


func _add_bubble(values : Array) -> void:
	bubble = Bubble.new()
	assert(bubble.connect("bubble_pressed", _on_bubble_pressed) == 0)
	var product = 1
	for i in values:
		product *= i
	bubble_string = Text.new(40, str(product))
	bubble_string.center_text()
	bubble.int_value = values
	bubble.gravity = 5
	bubble.position = Vector2(window.x/2, bubble.button.texture_normal.get_height()/2.0)
	add_child(bubble)
	bubble.add_child(bubble_string)
	bubble_positions = [2, -1, 1]


func _add_bullet(value : int, x_adjust : int) -> void:
	var bullet := Bullet.new()
	assert(bullet.connect("bullet_pressed", _on_bullet_pressed) == 0)
	assert(bullet.connect("target_reached", _on_target_reached) == 0)	
	bullet.int_value = [value]
	bullet.position = Vector2(x_adjust*100 + window.x/2, window.y - 150)	
	bullet_container.add_child(bullet)

	var bullet_string = Text.new(40, str(value))
	bullet_string.center_text()
	bullet.add_child(bullet_string)



func _correct_bullet(_name : String) -> bool:
	return bullet_container.get_node(chosen_bubble).int_value[0] in get_node(_name).int_value


func _accomplished() -> bool:
	return score == 10
