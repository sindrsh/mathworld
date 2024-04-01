extends Node

enum {COMPLETED, NOT_COMPLETED}
enum {INSIGHT, CALCULATION}

var current_game_path : String

var count_minigames:= {	
	"num_line_0_to_9": {
		"status": NOT_COMPLETED,
		"branch": INSIGHT,
		"score": 0
		},	
	"falling_numbers_0_to_9": {
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},
	"number_bridge_0_to_9": {
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},				
	"num_line_10_to_100": {
		"status": NOT_COMPLETED,
		"branch": INSIGHT,
		"score": 0
	},		
	"run_hill": {
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},	
	"amount_0_to_9": {
		"status": NOT_COMPLETED,
		"branch": INSIGHT,
		"score": 0
	},
	"match_0_to_9": {
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},
	"number_catch_0_to_9": {
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},
	"amount_0_to_50": {
		"status": NOT_COMPLETED,
		"branch": INSIGHT,
		"score": 0
	},
	"make_amounts_1_to_50": {
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},
	"snake_1_to_50": {
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0
	},			
	"amount_50_to_999": {
		"status": NOT_COMPLETED,
		"branch": INSIGHT,
		"score": 0
	},	
	"make_amounts_1_to_999": {
		"status": NOT_COMPLETED,
		"branch": CALCULATION,
		"score": 0,
	},	
}

var world_parts := {
	"counting": count_minigames
}


func get_game_index(game_array: Array, test_id: String):
	var index = null
	for i in range(game_array.size()):
		if game_array[i]["id"] == test_id:
			index = i
			break
	if index == null:
		print("error: ", test_id)
	assert(index != null)
	return index


func get_game_dictionary(game_array: Array, test_id: String) -> Dictionary:
	return game_array[get_game_index(game_array, test_id)]


func get_typeless_minigame_path(world_part : String, minigame : String) -> String:
	return "res://minigames/" + world_part + "/" + minigame + "/" + minigame
