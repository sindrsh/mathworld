extends Node

enum {COMPLETED, NOT_COMPLETED}
enum {INSIGHT, CALCULATION}


var count_number_line_minigames := [
	{
		"id": "falling_decimals_0_to_1",
		"status": NOT_COMPLETED,
		"branch": CALCULATION
	},
]

var count_amount_minigames := [
	{
		"id": "amount_0_to_9",
		"status": NOT_COMPLETED,
		"branch": INSIGHT
	},
	{
		"id": "match_0_to_9",
		"status": NOT_COMPLETED,
		"branch": CALCULATION
	},
	{
		"id": "number_catch_0_to_9",
		"status": NOT_COMPLETED,
		"branch": CALCULATION
	},
	{
		"id": "amount_0_to_50",
		"status": NOT_COMPLETED,
		"branch": CALCULATION
	}
]


var world_parts := {
	"counting": [count_amount_minigames, count_number_line_minigames]
}


func get_game_index(game_array: Array, test_id: String):
	var index = null
	for i in range(game_array.size()):
		if game_array[i]["id"] == test_id:
			index = i
			break
	assert(index != null)
	return index


func get_game_dictionary(game_array: Array, test_id: String) -> Dictionary:
	return game_array[get_game_index(game_array, test_id)]


func get_typeless_minigame_path(world_part : String, minigame : String) -> String:
	return "res://minigames/" + world_part + "/" + minigame + "/" + minigame
