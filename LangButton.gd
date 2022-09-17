extends MenuButton


func _ready():
	get_popup().add_item("norsk")
	get_popup().add_item("english")
	get_popup().add_item("ukrainian")
	get_popup().add_item("portuguese")
	get_popup().add_item("spanish")
	assert(get_popup().connect("index_pressed", self, "_on_lang_change") == 0)


func _on_lang_change(index):
	icon.set_current_frame(index) 
	var language = PlayerVariables.langs[index]
	PlayerVariables.current_lang = language
	get_parent()._on_lang_change()
