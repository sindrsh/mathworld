extends Control


var number_string = "";
@onready var label = get_node("Label");
signal number_entered(number: int);


func _on_number_pressed(number: String):
  number_string += number;
  label.text = number_string;


func _on_enter():
  emit_signal("number_entered", int(number_string));

  _on_clear();


func _on_clear():
  number_string = "";
  label.text = number_string;