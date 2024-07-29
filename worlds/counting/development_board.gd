extends Node2D

func get_status_indicator(id: String) -> Control:
	for node in get_children():
		match node.get("id"):
			id: 
				return node
			_:
				pass
	return null
	

func update(new_mini_game: bool):
	for id in GlobalVariables.completed_games:
		for game_rating in get_tree().get_nodes_in_group("GameRatings"):
			match game_rating.get("id"):
				id:
					if GlobalVariables.count_minigames[id]["branch"] != GlobalVariables.INSIGHT:
						game_rating.get_node("RatingIndicator").frame = GlobalVariables.count_minigames[id]["score"]
					else:
						if new_mini_game:
							await get_tree().create_timer(0.5).timeout
						game_rating.show()
