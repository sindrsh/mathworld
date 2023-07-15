extends Node

enum {COMPLETED, NOT_COMPLETED}

var save_dict := {
	"minigames": {
		"counting": [],
	}
}

var count_minigames := [
	{
		"id": "amount_0_to_9",
		"status": NOT_COMPLETED
	},
	{
		"id": "match_0_to_9",
		"status": NOT_COMPLETED
	},
	{
		"id": "number_catch_0_to_9",
		"status": NOT_COMPLETED
	}
]


var world_parts := {
	"counting": count_minigames
}


func get_game_index(game_array: Array, test_id: String):
	var index = null
	for i in range(game_array.size()):
		if game_array[i]["id"] == test_id:
			index = i
			break
	assert(index != null)
	return index
