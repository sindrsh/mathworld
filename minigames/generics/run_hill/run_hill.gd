extends MiniGame

var lane : Node2D = preload("res://minigames/generics/run_hill/lane.tscn").instantiate()
var alternatives := []
var start_value := 0
var music : AudioStream = preload("res://minigames/generics/assets/highway-167255.mp3")

# Called when the node enters the scene tree for the first time.
func _add_specifics():
	world_part = "counting"
	id = "run_hill"
	minigame_type = NUMBER_LINE
	
	alternatives = [$Alternative1, $Alternative2, $Alternative3, $Alternative4]
	assert(lane.make_new_alternatives.connect(_mk_new_alternatives) == 0)
	var ints := [1, 2, 3, 4, 5, 6, 7, 8, 9]
	for i in range(alternatives.size()):
		assert(alternatives[i].chosen.connect(_alternative_chosen) == 0)
				
	add_child(lane)
	_mk_alternatives()
	music_player.stream = music


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if lane.moving:
		lane.position.x -= lane.speed/1.4*delta


func _mk_alternatives() -> void:
	var ints = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	var indexes = [0, 1, 2, 3]
	
	randomize()
	indexes.shuffle()
	
	var i = indexes.pop_front()
	alternatives[i].position = Vector2(300 + i*200, 100)
	alternatives[i].value = lane.current_obstacle.value
	alternatives[i].get_node("Text").text = str(alternatives[i].value)
	
	ints.remove_at(lane.current_obstacle.value % 10 - 1)
	ints.shuffle()
	
	for j in indexes:
		alternatives[j].position = Vector2(300 + j*200, 100)
		alternatives[j].value = start_value + ints.pop_back()
		alternatives[j].get_node("Text").text = str(alternatives[j].value)
	start_value += 10
		
	

func _alternative_chosen(_name : String) -> void:
	lane.moving = true
	var obstacle = lane.current_obstacle
	lane.current_obstacle.has_been_hit = true
	var alt = get_node(_name)
	if alt.value == obstacle.value:
		obstacle.get_node("ObstacleShape").set_deferred("disabled", true)
	obstacle.get_node("ObstacleAnimation").hide()
	if obstacle.next_obstacle:
		lane.current_obstacle = obstacle.next_obstacle
		lane.current_obstacle.get_node("ObstacleAnimation").play()
		_mk_alternatives()
	else:
		for alternative in alternatives:
			alternative.hide()
	

func _mk_new_alternatives(value: int) -> void:
	pass
