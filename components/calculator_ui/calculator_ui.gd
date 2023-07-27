extends Control


var number_string = "";
@onready var label: Label = get_node("Label");
@onready var health_label: Label = get_node("Health");
@onready var score_label: Label = get_node("Score");
signal number_entered(number: int);


func _on_number_pressed(number: String):
  number_string += number;
  label.text = number_string;


func _on_enter():
  emit_signal("number_entered", int(number_string));

  _on_clear();


func _input(event):
  if event is InputEventKey:
    if event.pressed:
      if event.as_text_keycode() == "C":
        _on_clear()
      elif event.as_text_keycode() == "Enter":
        _on_enter()


func _on_clear():
  number_string = "";
  label.text = number_string;


func _on_shooter_score_changed(score: int):
  score_label.text = "Score: " + str(score);


func _on_shooter_damange_taken(health: int):
  health_label.text = "Health: " + str(health)  
