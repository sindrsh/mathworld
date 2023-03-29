extends Control

func _ready() -> void:
	# Set window size equal to the primary screen
	var primary_screen_index = DisplayServer.get_primary_screen();
	var screen_size = DisplayServer.screen_get_size(primary_screen_index);
	DisplayServer.window_set_position(screen_size * 0.05);
	DisplayServer.window_set_size(screen_size * 0.9);

	var m = $MarginContainer
	print(m.anchors_preset)
