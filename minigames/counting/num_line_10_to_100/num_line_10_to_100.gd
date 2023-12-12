extends MiniGame

#explanation

var tens_rolled := 0
var max_tens_rolled := 0
var reached100 := false
var insight_menu : TextureButton = preload("res://minigames/generics/insight_games/insight_achieved_button.tscn").instantiate()


func _add_specifics():
	assert($NumberLine.rolled_bckwd.connect(_on_number_line_rolled_bckwd) == 0)
	assert($NumberLine.rolled_fwd.connect(_on_number_line_rolled_fwd) == 0)
	assert($RollFwdButton.pressed.connect(_roll_fwd_button_pressed) == 0)
	assert($RollBckwdButton.pressed.connect(_roll_bckwd_button_pressed) == 0)
	
	world_part = "counting"
	id = "num_line_0_to_9"
	minigame_type = NUMBER_LINE
	$NumberLine.position = Vector2(958, 500)
	insight_menu.hide()
	add_child(insight_menu)
	
	
func _on_number_line_rolled_fwd(_add : bool) -> void:
	if _add:
		await $NumberLine.add_ten()
	$RollFwdButton.disabled = false
	
	
func _on_number_line_rolled_bckwd() -> void:
	$RollBckwdButton.disabled = false

func _roll_fwd_button_pressed() -> void:
	if tens_rolled == 9:
		if not reached100:
			$NumberLine.add_100()
			reached100 = true
			insight_menu.show()
		return
	if tens_rolled == max_tens_rolled:
		$NumberLine.roll_ten_fwd(true)
		max_tens_rolled += 1
	else:
		$NumberLine.roll_ten_fwd(false)
	$RollFwdButton.disabled = true
	tens_rolled += 1


func _roll_bckwd_button_pressed() -> void:
	if tens_rolled == 0:
		return
	$NumberLine.roll_ten_bckwd()	
	$RollBckwdButton.disabled = true
	tens_rolled -= 1
