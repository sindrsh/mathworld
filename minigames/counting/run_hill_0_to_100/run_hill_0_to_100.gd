extends "res://minigames/generics/run_hill/run_hill.gd"

func _add_specifics():
	id = "run_hill_0_to_100"
	
	lane.tick_hit.connect(_on_obstacle_hit)
	
	var ints := [1, 2, 3, 4, 5, 6, 7, 8, 9]
	for i in range(alternatives.size()):
		assert(alternatives[i].chosen.connect(_alternative_chosen) == 0)
				
	add_child(lane)
	_mk_alternatives()
	music_player.stream = music
