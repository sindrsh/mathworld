extends Node2D
const GameRating = preload("res://minigames/generics/game_rating.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	_update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func get_status_indicator(id: String) -> Control:
	for node in get_children():
		match node.get("id"):
			id: 
				return node
			_:
				pass
	return null
	

func _update():
	for id in GlobalVariables.count_minigames.keys():
		for game_rating in get_tree().get_nodes_in_group("GameRatings"):
			match game_rating.get("id"):
				id:
					game_rating.get_node("RatingIndicator").frame = GlobalVariables.count_minigames[id]["score"]
