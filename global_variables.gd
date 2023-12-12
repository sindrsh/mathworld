extends Node

enum {COMPLETED, NOT_COMPLETED}
enum {INSIGHT, CALCULATION}


var count_number_line_minigames := [	
	{
		"id": "num_line_0_to_9",
		"status": NOT_COMPLETED,
		"branch": INSIGHT
	},	
	{
		"id": "falling_numbers_0_to_9",
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},
	{
		"id": "number_bridge_0_to_9",
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},				
	{
		"id": "num_line_10_to_100",
		"status": NOT_COMPLETED,
		"branch": INSIGHT
	},		
	{
		"id": "run_hill",
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
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
		"branch": CALCULATION,
		"score": 0
	},
	{
		"id": "number_catch_0_to_9",
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},
	{
		"id": "amount_0_to_50",
		"status": NOT_COMPLETED,
		"branch": INSIGHT,
	},
	{
		"id": "make_amounts_1_to_50",
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},
	{
		"id": "snake_1_to_50",
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},			
	{
		"id": "amount_50_to_999",
		"status": NOT_COMPLETED,
		"branch": INSIGHT
	},	
	{
		"id": "make_amounts_1_to_999",
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},	
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
	if index == null:
		print(test_id)
	assert(index != null)
	return index


func get_game_dictionary(game_array: Array, test_id: String) -> Dictionary:
	return game_array[get_game_index(game_array, test_id)]


func get_typeless_minigame_path(world_part : String, minigame : String) -> String:
	return "res://minigames/" + world_part + "/" + minigame + "/" + minigame
