extends Area2D

var number_text : Text
var value : int

func _ready():
	assert(area_exited.connect(_on_area_exited) == 0)
	assert(area_entered.connect(_on_area_entered) == 0)

func _arrange(border_size : Vector2 = Vector2(300, 330)) -> void:
	$Border.shape.size = border_size
	$ColorRect.size = border_size
#	$Border.position.x -= border_size.x/2 
	$ColorRect.position = -border_size/2
	$CenterContainer.position.x += border_size.x/2 - 11.0
	$CenterContainer.position.y = -border_size.y/2
	number_text = Text.new(40, "0")
	$CenterContainer.add_child(number_text)	

func _on_area_exited(area : Area2D) -> void:
	value -= area.value
	number_text.text = str(value)


func _on_area_entered(area : Area2D) -> void:
	value += area.value
	number_text.text = str(value)
